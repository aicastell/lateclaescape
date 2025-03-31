---
title: Firmware OpenWrt en Xiaomi AX3600
date: 2025-02-22
image: /img/posts/firmware-openwrt-xiaomi-ax3600.webp
categories: [ "tecnología", "redes", "openwrt" ]
tags: [ "router", "xiaomi", "AX3600" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/firmware-openwrt-xiaomi-ax3600.mp3" >}}

# Introducción

Hace unas semanas publiqué un artículo hablando sobre el [sistema operativo OpenWrt](/post/2024/openwrt). Después hice una reseña del [router Xiaomi AX3600](/post/2024/router-xiaomi-ax3600). En este artículo vamos un paso mas allá. Hoy te voy a guiar, paso a paso, a través del proceso técnico para liberar el firmware del router AX3600 de Xiaomi, e instalar OpenWrt como su sistema operativo principal.

Routers de gama alta similares a este tienen un precio de 150€ o mas. Te animo a conseguir un AX3600 en Wallapop por unos 50€, y aventurarte a realizar el proceso por ti mismo. No solo te proporcionaré instrucciones claras y precisas, sino que también te explicaré el propósito detrás de cada paso. De esta manera, liberarás tu dispositivo, pero también aprenderás el por qué realizamos cada etapa del proceso. Sin más preámbulos, manos a la obra. ¡Hora de ponerse la máscara de anonymous!.

# Antecedentes

En [este post](https://forum.openwrt.org/t/adding-openwrt-support-for-xiaomi-ax3600-part-1/55049/29) del [foro OpenWrt](https://forum.openwrt.org/) se puede leer como la comunidad identificó el hardware del router AX3600 como muy apetecible, y se organizó para trabajar de forma colaborativa en busca de alguna vulnerabilidad. Finalmente, un usuario con el nick *LonGDikE* consigue acceso SSH con el usuario administrador en Mayo de 2020. A partir de aquí, el proceso es pan comido.

# Ataque por URL injection

Los ataques por *URL injection* permiten la ejecución de comandos no autorizados en un dispositivo mediante la manipulación de alguna URL que interactúa con dicho dispositivo. Este tipo de ataques explotan vulnerabilidades en la validación de entradas o en el manejo de solicitudes HTTP, permitiendo al atacante tomar el control del sistema de forma remota.

El acceso SSH al router está restringido por defecto. Sin embargo, el firmware oficial de Xiaomi versión 1.0.17 no está bien protegido y permite realizar un ataque al dispositivo por *URL injection*. Utilizando este ataque, habilitaremos el acceso SSH al dispositivo. Y una vez obtenido el acceso SSH, como verás, podremos hacer la magia.

# Pasos para el rooteo

El proceso completo de rooteo consiste en 4 pasos:

1. Descargar el firmware
2. Instalar el firmware vulnerable
3. Activar el acceso SSH
4. Instalar OpenWrt

# 1. Descargar el firmware

Crea un directorio donde vas a guardar todos los ficheros de firmware necesarios para realizar el proceso:

```
mkdir -p ~/Descargas/openwrt-xiaomi-ax3600
cd ~/Descargas/openwrt-xiaomi-ax3600
```

Descarga la versión vulnerable de firmware de Xiaomi. Es la versión oficial 1.0.17.

```
wget http://cdn.cnbj1.fds.api.mi-img.com/xiaoqiang/rom/r3600/miwifi_r3600_firmware_5da25_1.0.17.bin
```

El hash SHA256 debe ser el que te indico a continuación:

```
$ sha256sum miwifi_r3600_firmware_5da25_1.0.17.bin
dfbe347339903f2ae348be2e4b6434cc77dfd2247d970d7be7b3eac76731dd40  miwifi_r3600_firmware_5da25_1.0.17.bin
```

A continuación descarga desde la página oficial de OpenWrt las siguientes imágenes:

```
wget https://downloads.openwrt.org/snapshots/targets/qualcommax/ipq807x/openwrt-qualcommax-ipq807x-xiaomi_ax3600-initramfs-factory.ubi
wget https://downloads.openwrt.org/snapshots/targets/qualcommax/ipq807x/openwrt-qualcommax-ipq807x-xiaomi_ax3600-squashfs-sysupgrade.bin
```

Por último, descarga el último firmware de OpenWrt disponible para el router Xiaomi AX3600. En el momento de escribir este artículo se trata de la versión 23.05.5:

```
wget https://downloads.openwrt.org/releases/23.05.5/targets/ipq807x/generic/openwrt-23.05.5-ipq807x-generic-xiaomi_ax3600-squashfs-sysupgrade.bin
```

Ya has descargado todo el firmware necesario. Este paso es crucial, ya que durante el proceso de rooteo estarás sin conexión a Internet. Afortunadamente, no necesitarás descargar nada más.

# 2. Instalar el firmware vulnerable

## Setup Xiaomi network

El router AX3600 tiene como IP por defecto la 192.168.31.1 con netmask 255.255.255.0. Por lo tanto, necesitas configurar el interfaz de red de tu ordenador con una IP compatible con la red del router AX3600.

```
sudo ip address flush dev enp4s0
sudo ip address add 192.168.31.100/24 dev enp4s0
```

> Importante: cambia **enp4s0** por el nombre de tu interfaz de red (eth0, eth1, etc.).

Antes de continuar, conecta un cable ethernet desde el puerto LAN1 del router xiaomi a tu switch/hub. Y otro cable ethernet desde tu ordenador a ese mismo switch/hub. Después verifica que tienes conexión ethernet entre ambos:

```
$ ping 192.168.31.1 -c 3
PING 192.168.31.1 (192.168.31.1) 56(84) bytes of data.
64 bytes from 192.168.31.1: icmp_seq=1 ttl=119 time=19.3 ms
64 bytes from 192.168.31.1: icmp_seq=2 ttl=119 time=20.0 ms
64 bytes from 192.168.31.1: icmp_seq=3 ttl=119 time=19.2 ms

--- 192.168.31.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 19.170/19.459/19.950/0.349 ms
```

## Primer arranque del router

Utiliza chrome para acceder a la web de administración del router:

```
http://192.168.31.1
```

Verás que la página está en Chino, un idioma que personalmente no domino:

![Instalar openwrt xiaomi ax3600 firmware oficial chino](/img/firmware-openwrt-xiaomi-ax3600-oficial-chino.webp)

Utiliza el traductor del navegador *chrome* para traducir las página a español y entender los pasos que vayas realizando.

![Instalar openwrt xiaomi ax3600 conexión router operador](/img/firmware-openwrt-xiaomi-ax3600-conexion-router-operador.webp)

En este caso, el router está pidiendo que conectes el puerto WAN del Xiaomi AX3600 con un puerto ethernet del router de tu operador, ya que necesita detectar que tienes acceso a Internet. Mantén el cable LAN1 conectado a tu propio PC para continuar con el proceso.

Si lo haces bien, el router finalmente te pedirá configurar un *password* que te permitirá acceder a su web de administración. Pon algo simple y fácil de recordar, ya que este *password* se perderá cuando instales el firmware definitivo de OpenWrt.

## Instalar firmware vulnerable de Xiaomi

A continuación, es necesario instalar el firmware vulnerable en el router. La versión actual de tu router puede variar según la fecha en que lo hayas comprado. Para proceder, accede a la interfaz web de administración del router y navega hasta la sección de actualización de firmware. Haz clic en el botón para cargar un nuevo archivo y selecciona el archivo *miwifi_r3600_firmware_5da25_1.0.17.bin* que descargaste previamente. Deja que el proceso finalice sin interrupciones. Una vez que el router se reinicie, estará corriendo el firmware vulnerable 1.0.17.

# 3. Activar el acceso SSH

Vuelve a entrar en la web de administración:

```
http://192.168.31.1
```

La web te pedirá el *password* que has introducido antes. Escríbelo y clica en el botón de Login. Justo en este punto, detente, no toques nada.

![Instalar openwrt xiaomi ax3600 login url stok](/img/firmware-openwrt-xiaomi-ax3600-login-url-stok.webp)

Revisa la URL del router que ha salido en el navegador web. Debes localizar en la URL un campo en formato **stok=valor**, donde **valor** es una cadena de unos cuantos bytes en hexadecimal. Algo similar a esto:

```
stok=5405208568b0815fd1d9c465988edb89
```

Guarda ese valor de la variable *stok* porque lo tienes que poner en un script bash que te incluyo a continuación:

## Bash script

En tu PC, crea un script en bash con este contenido:

```
$ cat enableSsh.sh
#! /bin/bash

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
  REPLY="${encoded}"
}

xiaomiCmd() {
    parsed=$(rawurlencode "$1")
    url="http://192.168.31.1/cgi-bin/luci/;stok=$stok/api/misystem/set_config_iotdev?bssid=redmi&user_id=doctor&ssid=-h%0A$parsed%0A"
    echo $url
    curl "$url"
    echo
}

enableSsh() {
    xiaomiCmd "nvram set ssh_en=1;nvram commit"
    xiaomiCmd "sed -i '/flg_ssh.*release/ { :a; N; /fi/! ba };/return 0/d' /etc/init.d/dropbear"
    xiaomiCmd "echo -e '$password\n$password' | passwd root"
    xiaomiCmd "/etc/init.d/dropbear enable;/etc/init.d/dropbear start"
}

stok=5405208568b0815fd1d9c465988edb89
password=xiaomi
enableSsh
```

Este script realiza diversos cambios en la configuración del router Xiaomi AX3600 mediante comandos HTTP enviados con *curl*. Es importante que prestes atención a las tres últimas líneas del script, ya que deberás personalizar dos variables. Primero, reemplaza el valor de la variable *stok* con el que hayas obtenido previamente para tu router. Luego, modifica el valor de la variable *password* con la contraseña que desees asignar al usuario root para acceder al router por SSH. Ten en cuenta que esta contraseña es temporal y se perderá una vez que instales el firmware definitivo de OpenWRT. En mi caso, he utilizado una contraseña simple: xiaomi.

Una vez modificado el script, habilita los permisos de ejecución, y ejecútalo, dale sin miedo:

```
$ chmod +x enableSsh.sh
$ ./enableSsh.sh
```

Ahora usa el *password* que acabas de configurar (*xiaomi*), para verificar que ya tienes habilitado el acceso SSH a través del usuario root:

```
$ ssh -oHostKeyAlgorithms=+ssh-rsa root@192.168.31.1
```

![OpenWrt Xiaomi AX3600 acceso ssh](/img/firmware-openwrt-xiaomi-ax3600-acceso-ssh.webp)

¡Buen trabajo! Ya tienes acceso SSH al router con el usuario root. Este router ya está listo para iniciar su camino hacia la libertad.

# 4. Instalar OpenWrt

## Initramfs

Transfiere el fichero *openwrt-qualcommax-ipq807x-xiaomi_ax3600-initramfs-factory.ubi* al directorio temporal del router:

```
$ scp -O -oHostKeyAlgorithms=+ssh-rsa openwrt-qualcommax-ipq807x-xiaomi_ax3600-initramfs-factory.ubi root@192.168.31.1:/tmp/
```

Conecta por SSH al router:

```
$ ssh -oHostKeyAlgorithms=+ssh-rsa root@192.168.31.1
```

El siguiente comando te mostrará todas las particiones que tiene su memoria NAND flash:

```
root@XiaoQiang:~# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00100000 00020000 "0:SBL1"
mtd1: 00100000 00020000 "0:MIBIB"
mtd2: 00300000 00020000 "0:QSEE"
mtd3: 00080000 00020000 "0:DEVCFG"
mtd4: 00080000 00020000 "0:RPM"
mtd5: 00080000 00020000 "0:CDT"
mtd6: 00080000 00020000 "0:APPSBLENV"
mtd7: 00100000 00020000 "0:APPSBL"
mtd8: 00080000 00020000 "0:ART"
mtd9: 00080000 00020000 "bdata"
mtd10: 00080000 00020000 "crash"
mtd11: 00080000 00020000 "crash_syslog"
mtd12: 023c0000 00020000 "rootfs"
mtd13: 023c0000 00020000 "rootfs_1"
mtd14: 01ec0000 00020000 "overlay"
mtd15: 00080000 00020000 "rsvd0"
mtd16: 0041e000 0001f000 "kernel"
mtd17: 015cc000 0001f000 "ubi_rootfs"
mtd18: 01876000 0001f000 "data"
```

El sistema tiene dos particiones rootfs etiquetadas como "rootfs" y "rootfs_1". Confirma en el listado anterior que sus ficheros dispositivos asociados son /dev/mtd12 y /dev/mtd13 respectivamente.

Averigua qué partición del rootfs se está usando para arrancar actualmente tu router. Para ello debes consultar el valor almacenado en la variable *flag_boot_rootfs* en la memoria NVRAM que almacena configuraciones persistentes del sistema.

```
root@XiaoQiang:~# nvram get flag_boot_rootfs
0
```

En caso de obtener un 0, tu sistema utiliza la partición etiquetada como "rootfs", que se encuentra mapeada en /dev/mtd12. Si obtienes un 1, tu sistema utiliza la partición etiquetada como "rootfs_1", que se encuentra mapeada en /dev/mtd13.

El siguiente comando tiene dos variantes, en función del valor obtenido para la variable *flag_boot_rootfs*. Si su valor es 0, procede de esta manera:

```
root@XiaoQiang:~# ubiformat /dev/mtd13 -y -f /tmp/openwrt-qualcommax-ipq807x-xiaomi_ax3600-initramfs-factory.ubi -s 2048 -O 2048 && nvram set flag_boot_rootfs=1 && nvram set flag_last_success=1 && nvram commit
```

Y si su valor es 1, procede de esta otra manera:

```
root@XiaoQiang:~# ubiformat /dev/mtd12 -y -f /tmp/openwrt-qualcommax-ipq807x-xiaomi_ax3600-initramfs-factory.ubi -s 2048 -O 2048 && nvram set flag_boot_rootfs=0 && nvram set flag_last_success=0 && nvram commit
```

El comando *ubiformat* ha grabado la imagen initramfs de OpenWrt en la partición libre de la memoria flash, preparando el sistema para que, en el siguiente arranque, se ejecute una versión preliminar de OpenWrt desde la que podremos finalizar el proceso.

Tras el comando ubiformat, se han ejecutado dos comandos *set* para manipular las variables *flag_boot_rootfs* y *flag_last_success*. De esta manera, el router se va a reiniciar utilizando como rootfs el nuevo sistema de ficheros que acabas de flashear.

Hecha la explicación, a continuación, reinicia el dispositivo y espera hasta que vuelva a estar online.

```
root@XiaoQiang:~# reboot
```

## Setup OpenWrt network

El router acaba de arrancar una versión preliminar de OpenWrt. Esta versión lleva como IP por defecto la 192.168.1.1 y como netmask la 255.255.255.0. Así que lo primero que debes hacer es reconfigurar la IP de tu PC para estar en la misma subred que el router.

```
sudo ip address flush dev enp4s0
sudo ip address add 192.168.1.100/24 dev enp4s0
```

Espera hasta que el dispositivo esté online:

```
$ ping -c 3 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.490 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.445 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=0.418 ms

--- 192.168.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2044ms
rtt min/avg/max/mdev = 0.418/0.451/0.490/0.029 ms
```

## SquashFS

A continuación, transfiere el fichero *openwrt-qualcommax-ipq807x-xiaomi_ax3600-squashfs-sysupgrade.bin* al directorio temporal del router:

```
$ scp -O openwrt-qualcommax-ipq807x-xiaomi_ax3600-squashfs-sysupgrade.bin root@192.168.1.1:/tmp/
```

Seguidamente, conecta de nuevo al router por SSH:

```
$ ssh root@192.168.1.1
```

![OpenWrt Xiaomi AX3600 acceso ssh initram factory](/img/firmware-openwrt-xiaomi-ax3600-acceso-openwrt-initram-factory.webp)

Y ejecuta el siguiente comando:

```
root@OpenWrt:~# sysupgrade -n /tmp/openwrt-qualcommax-ipq807x-xiaomi_ax3600-squashfs-sysupgrade.bin
```

Este paso es el que actualiza el dispositivo utilizando una imagen de firmware squashfs, comprimida y de solo lectura, diseñada como paso previo para realizar instalaciones permanentes en dispositivos NAND. Espera a que se reinicie el router de nuevo.

## Instalar OpenWrt latest

A partir de este punto ya puedes instalar la versión definitiva de OpenWrt, actualmente la versión 23.05.5. Transfieres esta imagen al directorio temporal del router:

```
$ scp -O openwrt-23.05.5-ipq807x-generic-xiaomi_ax3600-squashfs-sysupgrade.bin root@192.168.1.1:/tmp/
```

Seguidamente, conecta de nuevo al router por SSH:

```
$ ssh root@192.168.1.1
```

Y como último paso, la instalas:

```
root@OpenWrt:~# sysupgrade -n /tmp/openwrt-23.05.5-ipq807x-generic-xiaomi_ax3600-squashfs-sysupgrade.bin
```

Cuando el dispositivo se reinicie, ya tendrás el router instalado con OpenWrt. ¡Enhorabuena, lo has logrado!.

Puedes verificarlo, navegando a esta URL desde tu browser:

```
http://192.168.1.1
```

Disfruta de tu nuevo router Xiaomi AX3600 con OpenWrt instalado:

![OpenWrt Xiaomi AX3600 lucy status](/img/firmware-openwrt-xiaomi-ax3600-lucy-status.webp)

# Despedida

En este artículo logramos instalar con éxito el firmware de OpenWRT en el router Xiaomi AX3600, lo que nos permite acceder a una amplia gama de opciones de personalización y control avanzado sobre nuestra red. Esta instalación no solo mejora el rendimiento y la flexibilidad del dispositivo, sino que también abre la puerta a una mayor seguridad y optimización a través de las herramientas avanzadas de OpenWRT. En mi caso en particular, he convertido este dispositivo en el router principal de mi hogar.

Si te encuentras con problemas o dudas durante el proceso, no dudes en contactarme a través del [canal de Telegram](https://t.me/lateclaescape). Estaré atento para resolver cualquier cuestión que quieras plantear sobre este router en particular.

Como con cualquier customización de firmware, siempre existe el riesgo de que el dispositivo se "brickee" en el proceso. En el próximo artículo, profundizaré en cómo desbrickear este router Xiaomi AX3600 en caso de que algo salga mal durante la instalación o en cualquier otro momento. ¡Nos vemos en el próximo artículo!

Pulso la tecla [ESC01](https://challenge.lateclaescape.com/), dos puntos wq!
