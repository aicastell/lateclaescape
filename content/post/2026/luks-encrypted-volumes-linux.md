---
title: Volúmenes cifrados con LUKS
date: 2026-04-24
image: /img/posts/luks-encrypted-volumes-linux.webp
categories: [ "cybersecurity", "criptografía" ]
tags: [ "LUKS", "clave_simétrica", "ext4" ]
draft: false
featured: true
---

# Motivación

En [el manifiesto](/post/2024/la-tecla-esc-manifiesto) que dio origen a este blog, hablamos sin rodeos de una realidad incómoda: Internet nos espía. No es una idea lejana ni teórica.
De hecho, viene muy al caso para introducir este articulo.

Subir archivos a la nube se ha convertido en algo que mucha gente hace sin pensar. Fotos, documentos, backups... Todo acaba, tarde o temprano, en algún servidor remoto en Internet, fuera de nuestro control.

Cada vez que subes un archivo a la nube, estás haciendo un acto de fe. Estás confiando en terceros. Y por mucha confianza que te inspire tu proveedor, siempre existen riesgos: accesos no autorizados, filtraciones, errores de configuración, o simplemente cambios en las condiciones del servicio.

Aquí es donde muchos se equivocan. La solución no es confiar más. La solución es necesitar confiar menos. Y es justo en ese punto donde entra en escena una herramienta fundamental en Linux: LUKS.

Y no, no estoy hablando de **LUKS Skywalker**. Ni pilota un X-Wing, ni usa la fuerza... Y, por desgracia, tampoco va a aparecer en el último momento para salvar tus datos personales.

Pero lo que sí hace muy bien (bastante mejor que cualquier *Jedi* en este contexto) es proteger tu información antes de que salga de tu máquina.

En este artículo voy a explicar qué es LUKS y cómo utilizarlo para cifrar tus datos antes de subirlos a la nube, de forma que sigan siendo tuyos incluso cuando ya no estén en tus manos. Prepárate, porque a partir de aquí, la seguridad deja de ser una promesa. Y pasa a ser una decisión.

## Cifrar antes de subir

En lugar de subir tus archivos en claro, puedes hacer lo siguiente:

- Crear un volumen cifrado en local
- Trabajar con él como si fuera un disco normal
- Cerrar el volumen (dejándolo completamente cifrado)
- Subir ese volumen cifrado a la nube

De esta forma:

- El proveedor de la nube solo ve un fichero cifrado.
- La clave de cifrado queda bajo tu control.
- La seguridad ya no depende de terceros.

## ¿Qué es LUKS?

LUKS (Linux Unified Key Setup) es el estándar de cifrado de discos en Linux. Se utiliza habitualmente para:

- cifrar discos completos
- proteger particiones
- crear volúmenes cifrados dentro de ficheros

Internamente, LUKS:

- usa [cifrado simétrico](/post/2024/criptografia-simetrica) (normalmente AES)
- protege las claves mediante passphrases (contraseñas)
- integra todo en el subsistema *device mapper*

El resultado es un dispositivo que, una vez abierto, se comporta como cualquier otro disco.

## Flujo de trabajo típico

El patrón que vamos a seguir es este:

- Crear volumen cifrado
- Abrirlo
- Montarlo
- Trabajar con él
- Desmontarlo
- Cerrarlo

Después de cerrarlo, el fichero vuelve a ser completamente opaco.

## Ejemplo práctico

Vamos a crear un volumen cifrado, a usarlo, y a dejarlo listo para subir a la nube.

### Preparar el entorno

Antes de empezar asegúrate que tienes instaladas las herramientas necesarias en tu ordenador.

En sistemas basados en Debian o Ubuntu, basta con instalar este paquete:

```
sudo apt update
sudo apt install cryptsetup-bin
```

Este paquete incluye el comando *cryptsetup*, que es el necesario para crear y gestionar volúmenes cifrados con LUKS.

Si estás usando otra distribución, el nombre del paquete puede variar ligeramente, pero el concepto es el mismo.

### Crear el volumen

Primero creamos un fichero *secure-volume.img* que actuará como disco virtual:

```
dd if=/dev/zero of=secure-volume.img bs=1M count=500
```

Esto crea un fichero de 500 MB lleno de ceros. Ajusta el tamaño según tus necesidades.

### Cifrar el volumen

Ahora convertimos ese fichero en un volumen cifrado:

```
sudo cryptsetup luksFormat secure-volume.img
```

Este paso:

- escribe la cabecera LUKS.
- configura los parámetros de cifrado.
- te pedirá una contraseña que debes guardar de forma segura.

### Abrir el volumen cifrado

Abrimos el volumen cifrado:

```
sudo cryptsetup open secure-volume.img encrypted-volume
```

Este comando te pedirá la contraseña para abrir el volumen cifrado. Si pones la correcta, Linux crea un dispositivo *mapper* con el nombre que hayas establecido en el parámetro anterior. En este ejemplo, has usado el nombre *encrypted-volume*. Por tanto, el kernel de Linux le ha asignado exactamente ese nombre:

```
$ ls -l /dev/mapper
/dev/mapper/encrypted-volume
```

A partir de aquí, el sistema ve este dispositivo *mapper* como un disco normal, descifrado en tiempo real.

### Crea un sistema de ficheros

Ahora crea un sistema de ficheros dentro. En este ejemplo creamos un ext4 con la herramienta *mkfs.ext4*:

```
sudo mkfs.ext4 /dev/mapper/encrypted-volume
```

Esto es equivalente a formatear un disco en formato *ext4*.

### Montar el volumen

Con este comando vas a montar el dispositivo *mapper* en cualquier directorio de tu sistema de ficheros. En este ejemplo, en /media/secure:

```
sudo mkdir -p /media/secure
sudo mount /dev/mapper/encrypted-volume /media/secure
```

### Trabajar con el volumen

Ahora puedes trabajar normalmente. Puedes crear directorios:

```
mkdir -p /media/secure/docs
mkdir -p /media/secure/imgs
```

Y puedes copiar ficheros dentro de esos directorios:

```
cp mydoc.txt /media/secure/docs
cp myimage.png /media/secure/imgs
```

Desde tu punto de vista, /media/secure es un directorio más de tu sistema de ficheros. Puedes hacer dentro de él lo que quieras (crear ficheros y directorios, renombrarlos, borrarlos, etc). Lo mismo que con cualquier otro directorio de tu sistema de ficheros. Los cambios terminaran todos dentro del volumen cifrado, que tú has llamado *secure-volume.img*.

### Desmontar el volumen y cerrarlo

Cuando termines, desmontas el disco y el volumen cifrado:

```
sudo umount /media/secure
sudo cryptsetup close encrypted-volume
```

En este momento ocurren 2 cosas:

- El dispositivo *mapper* (*encrypted-volume* en este ejemplo) desaparece.
- El contenido del volumen *secure-volume.img* queda completamente cifrado (es totalmente ilegible sin la contraseña para abrirlo).

### Subir a la nube

Ahora puedes subir el volumen cifrado *secure-volume.img* a la nube de cualquier proveedor:

- Google Drive
- Dropbox
- S3
- Nextcloud

Lo único que verán será un fichero encriptado. Sin la contraseña, su contenido es irrecuperable.

## Nivel de seguridad

Este enfoque tiene varias propiedades muy interesantes:

- Tus datos están cifrados antes de salir de tu máquina. Nadie en la nube puede leerlos.
- No dependes de cifrado en el servidor o de políticas internas del proveedor.
- Tienes control total sobre la contraseña (solo tú la conoces).

## Aspectos a tener en cuenta

Aunque LUKS es muy robusto, conviene tener en cuenta algunos puntos importantes:

- Si pierdes la contraseña, pierdes los datos. No hay recuperación posible (es totalmente seguro).
- El fichero es monolítico. Todo está dentro de un único archivo, por tanto, cualquier cambio implica subir todo el fichero.
- El cifrado introduce cierta sobrecarga, aunque en sistemas modernos suele ser mínima gracias a aceleración por hardware.

## Conclusión

Subir datos a la nube sin cifrar es, en el fondo, una cesión silenciosa de control. No es que los proveedores sean necesariamente inseguros, pero el modelo implica confiar en terceros. Y en seguridad informática, la confianza es siempre una superficie de riesgo.

Con LUKS, ese modelo cambia por completo. Tus datos salen de tu máquina ya protegidos, y permanecen así en todo momento, independientemente de dónde acaben almacenados. La nube pasa de ser un espacio de confianza a ser simplemente un medio de almacenamiento.

Este enfoque resulta especialmente útil en escenarios donde la privacidad no es negociable: backups sensibles, documentación crítica o, sencillamente, cualquier información personal que no quieras delegar en terceros.

La idea clave es sencilla, pero poderosa: no se trata de confiar más en la nube, sino de necesitar confiar menos.

Si este contenido te ha resultado útil, puedes unirte al [canal de Telegram](https://t.me/lateclaescape). Es totalmente gratuito y encontrarás una comunidad con bastante nivel técnico donde debatir, aprender y resolver dudas con otros profesionales.

Nos vemos en el próximo artículo.

Pulso la tecla `ESC:wq!`
