---
title: ESC01 Solved
date: 2025-03-19
image: /img/posts/challenge-esc01-solved.webp
categories: [ "blog", "esc01", "cybersecurity" ]
tags: [ "challenge", "CTF", "base64", "ASCII" ]
draft: false
featured: true
---

# Cybersecurity challenge

Hace unas semanas, [LaTeclaESC](htts://www.lateclaescape.com) lanzó el primer desafío criptográfico de su historia. El denominado [Challenge ESC01](/post/2025/challenge-esc01), consistía en un reto tipo *Capture The Flag (CTF)* diseñado para poner a prueba vuestro ingenio y vuestras habilidades en el mundo de la criptografía.

Tras días de mucha incertidumbre, un participante logró resolverlo con éxito. Este artículo explica en detalle cómo se podía llegar a la solución, los conceptos clave utilizados y los aprendizajes que dejó este desafío. ¿Listo para descifrar el misterio? ¡Vamos allá!

# Proceso de inscripción

Cada concursante inscrito por email recibía como respuesta una [clave simétrica](/post/2024/criptografia-simetrica) que debía usarse durante el reto: esc.2501aeJei7io4Zangei2Reimi

Adicionalmente, podía recibir una primera pista enviando el link del challenge a 3 contactos en CC. Esta era la primera pista:

> **PISTA1**: Leer el articulo publicado en el blog sobre sistemas de codificación te dará una gran ventaja

El reto pasó a estado de RUNNING tras publicar un articulo donde hablamos sobre como [Instalar OpenWrt en Xiaomi AX3600](https://www.lateclaescape.com/post/2025/firmware-openwrt-xiaomi-ax3600/). Un articulo sobre hackers era un buen momento para arrancar un challenge sobre ciberseguridad. Al final del articulo, los lectores tuvisteis disponible un enlace al reto que os otorgó una ventaja temporal de 24 horas respecto al resto de los participantes:

Pulso la tecla [ESC01](https://challenge.lateclaescape.com/), dos puntos wq!

# Formulario

Al pulsar el link del enlace [ESC01](https://challenge.lateclaescape.com/), se abre el formulario del challenge:

![Formulario challenge ESC01](/img/esc01-solved-form.webp)

El formulario solicita un usuario y una contraseña. Sin importar qué credenciales utilices, devuelve un mensaje de error. Este mensaje contiene una pequeña pista que debía ayudarte a superar este paso:

![Formulario challenge ESC01 form error](/img/esc01-solved-form-error.webp)

Un formulario web se basa principalmente en HTML para definir su estructura y en JavaScript para gestionar la interacción del usuario y validar las credenciales. La clave aquí era inspeccionar su código fuente, un proceso sencillo que puedes realizar haciendo clic sobre el formulario con el botón derecho del ratón, y seleccionando "Ver código fuente de la página".

![Formulario challenge ESC01 form javascript](/img/esc01-solved-form-javascript.webp)

En el código fuente, puedes encontrar hardcoded el usuario y el password:

```
const correctUser = "keychron-k8"
const correctPassword = "seraparami";
```

Introduces como usuario "keychron-k8" y como password "seraparami", y se descarga un objeto encriptado. El formulario ofrece ayuda adicional para guiarte en el proceso:

![Formulario challenge ESC01 form ok](/img/esc01-solved-form-ok.webp)

# Fichero encriptado

Se descarga un fichero llamado challenge-esc01.7z. Este fichero está comprimido con el compresor 7-zip. Se puede descomprimir con este comando:

```
$ 7z x challenge-esc01.7z

7-Zip [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=es_ES.UTF-8,Utf16=on,HugeFiles=on,64 bits,8 CPUs Intel(R) Core(TM) i7-5700HQ CPU @ 2.70GHz (40671),ASM,AES-NI)

Scanning the drive for archives:
1 file, 1175 bytes (2 KiB)

Extracting archive: challenge-esc01.7z

Enter password (will not be echoed):
```

Al intentar descomprimirlo te solicita una contraseña. Aquí es donde debes usar la clave simétrica que recibiste durante el proceso de inscripción. De esta manera, a partir de este momento, solo los inscritos al reto pueden continuar con el proceso.

Insertando el password obtenido durante la inscripción, se extrae un directorio llamado *challenge-esc01*. Dentro de este directorio puedes encontrar dos archivos:

```
$ cd challenge-esc01/
$ ls
encoded_message  README
```

Lo primero es leer el contenido del fichero README:

```
$ cat README
Si estas leyendo este mensaje es porque estas correctamente inscrito al challenge ESC01 del blog LaTeclaEsc.
Las instrucciones para resolver este reto son las siguientes:
    - El fichero "encoded_message" va codificado
    - El reto consiste en decodificarlo para extraer el mensaje que lleva oculto.
    - El primer concursante que lo logre, tiene premio asegurado.
No hay nada de interes en este fichero README, puedes borrarlo.
Centrate en decodificar el contenido del fichero "encoded_message".
Pulso la tecla ESC, :wq!
```

A partir de aquí, puedes borrar el archivo README. El reto se centra en decodificar el contenido del fichero *encoded_message*.

# Mensaje codificado

Como primer paso, revisa el contenido del mensaje codificado:

```
$ cat encoded_message
u5qMm5rfmpPfnZOQmN+znquanJOeuqy834ua35uQht+Tnt+6sbewrb69qrqxvt+PkI3fjZqMkJOJmo3fuqy8z87T35qT34+NlpKajd+8l56Tk5qRmJrfm5rfnJadmo2MmpiKjZabnpvfzc/NytHfvJCSkN+NmpyQko+akYye34+Qjd+Lit+ajJmKmo2FkN+G356YjZ6bmpyWkpaakYuQ34+Qjd+Lit+Zlpuak5abnpvT34ua342amJ6TkN+Kkd+LmpyTnpuQ35KanDxekZackN+0moacl42Qkd+0x9+LkIuek5KakYua35iNnouKPFKLkNPfmpPfkpaMkpDfnJCR35qT346Kmt+Xmt+ajJyNlouQ35qMi5rfi5qHi5DR36+QkYua35qR35yQkYuenIuQ35yQkd+ak9+dk5CY09+akYmWnpGbkN+Kkd+akp6Wk9+e35Oei5qck56ajJyej5q/mJKelpPRnJCS09+ckI+WnpGbkN+G34+amJ6Rm5DfmoyLmt+LmoeLkN+akd+ak9+ckI2NmpDfj56Nnt+bmpKQjIuNno3fjoqa35eejN+NmoyKmpOLkN+ak9+cl56Tk5qRmJrR37GQ35CTiZabmozfnpuVipGLno3fi4rfm5aNmpycljxMkd+Pno2e35eenJqNi5rfmpPfmpGJPFKQ0d+yipyXnozfmI2enJaejN+PkI3fj56Ni5aclo+ejdPfht+XnoyLnt+ak9+PjZCHlpKQ342ai5De36+Kk4yQ35Oe34uanJOe37qsvNPfm5CM34+KkYuQjN+Ijt4=
```

Viendo el contenido, y tras leer el articulo citado en la **PISTA1** sobre [sistemas de codificación](https://www.lateclaescape.com/post/2024/sistemas-de-codificacion/), te puedes llegar a imaginar que este código esta codificado en *base64*. Veamos el resultado de decodificarlo:

```
$ cat encoded_message | base64 -d | xxd -p
bb9a8c9b9adf9a93df9d939098dfb39eab9a9c939ebaacbcdf8b9adf9b90
86df939edfbab1b7b0adbebdaabab1bedf8f908ddf8d9a8c9093899a8ddf
baacbccfced3df9a93df8f8d96929a8ddfbc979e93939a91989adf9b9adf
9c969d9a8d8c9a988a8d969b9e9bdfcdcfcdcad1dfbc909290df8d9a9c90
928f9a918c9edf8f908ddf8b8adf9a8c998a9a8d8590df86df9e988d9e9b
9a9c9692969a918b90df8f908ddf8b8adf99969b9a93969b9e9bd3df8b9a
df8d9a989e9390df8a91df8b9a9c939e9b90df929a9c3c5e91969c90dfb4
9a869c978d9091dfb4c7df8b908b9e93929a918b9adf988d9e8b8a3c528b
90d3df9a93df92968c9290df9c9091df9a93df8e8a9adf979adf9a8c9c8d
968b90df9a8c8b9adf8b9a878b90d1dfaf90918b9adf9a91df9c90918b9e
9c8b90df9c9091df9a93df9d939098d3df9a9189969e919b90df8a91df9a
929e9693df9edf939e8b9a9c939e9a8c9c9e8f9abf98929e9693d19c9092
d3df9c908f969e919b90df86df8f9a989e919b90df9a8c8b9adf8b9a878b
90df9a91df9a93df9c908d8d9a90df8f9e8d9edf9b9a92908c8b8d9e8ddf
8e8a9adf979e8cdf8d9a8c8a9a938b90df9a93df9c979e93939a91989ad1
dfb190df909389969b9a8cdf9e9b958a918b9e8ddf8b8adf9b968d9a9c9c
963c4c91df8f9e8d9edf979e9c9a8d8b9adf9a93df9a91893c5290d1dfb2
8a9c979e8cdf988d9e9c969e8cdf8f908ddf8f9e8d8b969c968f9e8dd3df
86df979e8c8b9edf9a93df8f8d9087969290df8d9a8b90dedfaf8a938c90
df939edf8b9a9c939edfbaacbcd3df9b908cdf8f8a918b908cdf888ede
```

A partir de aquí, podrías darle a la imaginación, o esperar a la segunda pista:

> **PISTA2**: Darle la vuelta te puede ofrecer una perspectiva diferente

Para cualquier informático, queda bastante claro que darle la vuelta a un mensaje, puede significar invertir ceros por unos, y unos por ceros. Para ello, podemos usar este comando:

```
$ cat encoded_message | base64 -d | xxd -p | tr '0123456789abcdef' 'fedcba9876543210'
446573646520656c20626c6f67204c615465636c6145534320746520646f
79206c6120454e484f52414255454e4120706f72207265736f6c76657220
45534330312c20656c207072696d6572204368616c6c656e676520646520
636962657273656775726964616420323032352e20436f6d6f207265636f
6d70656e736120706f72207475206573667565727a6f2079206167726164
6563696d69656e746f20706f7220747520666964656c696461642c207465
20726567616c6f20756e207465636c61646f206d6563c3a16e69636f204b
65796368726f6e204b3820746f74616c6d656e7465206772617475c3ad74
6f2c20656c206d69736d6f20636f6e20656c207175652068652065736372
69746f206573746520746578746f2e20506f6e746520656e20636f6e7461
63746f20636f6e20656c20626c6f672c20656e7669616e646f20756e2065
6d61696c2061206c617465636c6165736361706540676d61696c2e636f6d
2c20636f7069616e646f207920706567616e646f20657374652074657874
6f20656e20656c20636f7272656f20706172612064656d6f737472617220
717565206861732072657375656c746f20656c206368616c6c656e67652e
204e6f206f6c76696465732061646a756e74617220747520646972656363
69c3b36e2070617261206861636572746520656c20656e76c3ad6f2e204d
7563686173206772616369617320706f7220706172746963697061722c20
7920686173746120656c2070726f78696d6f207265746f212050756c736f
206c61207465636c61204553432c20646f732070756e746f7320777121
```

El comando "tr", traduce cualquier 0 por una f, cualquier 1 por una e, cualquier 2 por una d, y así sucesivamente hasta la f por un 0. Es decir, substituimos cada dígito hexadecimal, por su equivalente negado, cambiando ceros por unos y unos por ceros.

Desde este punto, de nuevo podrías darle a la imaginación, o esperar a la tercera pista:

> **PISTA3**: cada letra tiene un valor perfectamente codificado en un antiguo estándar que todos conocemos

Cualquier informático entiende que el estándar referenciado que codifica letras es el ASCII. Y de nuevo, si volvemos al articulo sobre [sistemas de codificación](https://www.lateclaescape.com/post/2024/sistemas-de-codificacion/), tenemos una explicación muy clara de como funciona este estándar. Si convertimos cada 2 dígitos en hexadecimal, a su equivalente en el estándar ASCII, parece que se construye la cadena "Desde":

```
0x44 -> D
0x65 -> e
0x73 -> s
0x64 -> d
0x65 -> e
...
```

Podrias seguír decodificando caracter a caracter el resto del mensaje. Pero es mas fácil usar una herramienta que haga ese trabajo por nosotros. El siguiente comando decodifica toda la secuencia de bytes hexadecimales, a su equivalente en ASCII:

```
$ cat encoded_message | base64 -d | xxd -p | tr '0123456789abcdef' 'fedcba9876543210' | xxd -r -p
Desde el blog LaTeclaESC te doy la ENHORABUENA por resolver ESC01, el primer Challenge de ciberseguridad 2025. Como recompensa por tu esfuerzo y agradecimiento por tu fidelidad, te regalo un teclado mecánico Keychron K8 totalmente gratuíto, el mismo con el que he escrito este texto. Ponte en contacto con el blog, enviando un email a lateclaescape@gmail.com, copiando y pegando este texto en el correo para demostrar que has resuelto el challenge. No olvides adjuntar tu dirección para hacerte el envío. Muchas gracias por participar, y hasta el proximo reto! Pulso la tecla ESC, dos puntos wq!
```

# Resolución

El 13 de marzo de 2025, a escasas 48 horas de expirar el plazo máximo para resolverlo, llega el correo de un concursante que ha logrado resolver el reto, con el mérito adicional de hacerlo sin solicitar ni la **PISTA2** ni la **PISTA3**. ¡Que bien lo has hecho!. Enhorabuena compañero, ¡espero que surjan grandes proyectos de LaTeclaESC de tu nuevo teclado!.

El día de la publicación de este articulo, el ganador ya está disfrutando de su nuevo teclado mecánico [Keychron K8](/post/2025/mechanical-keyboard-keychron-k8).

# Conclusión

A todos los participantes, agradeceros tanto el seguimiento como la difusión de este reto. Y recordaros que durante 2025 habrá un segundo challenge con otro premio. ¡Así que atentos porque habrá mas sorpresas!

Quiero añadir que el concursante que ha logrado resolver el reto es uno de los seguidores del [canal de Telegram](https://t.me/lateclaescape). Lo que demuestra que estar atento a las novedades de este canal ofrece cierta ventaja sobre el resto de los participantes. Así que, si aún no lo has hecho, te animo a subscribirte al canal, es totalmente gratuito, hay gente muy maja por aquí que siempre está dispuesta a ayudar, y seguro que entre todos aprenderemos un montón.

¡Nos vemos en el próximo articulo!

Pulso la tecla ESC, dos puntos wq!
