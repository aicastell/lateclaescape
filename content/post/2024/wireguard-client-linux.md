---
title: Wireguard en Linux
date: 2024-04-29
image: /img/posts/wireguard-client-linux.webp
categories: [ "redes", "cybersecurity" ]
tags: [ "VPN", "WireGuard", "Linux" ]
draft: false
featured: true
---

# Motivación

En artículos anteriores has aprendido a instalar y configurar un [servidor WireGuard](/post/2024/wireguard-server) y un [cliente WireGuard en Android](/post/2024/wireguard-client-android).

Para finalizar esta serie de artículos sobre WireGuard, en este articulo voy a explicar como instalar y configurar un cliente de WireGuard en Linux. Y es que, por si alguien sigue con dudas a estas alturas, WireGuard funciona especialmente bien con Linux.

# Instalación en Linux

Para instalar el cliente de WireGuard con Linux, voy a usar la distribución de Linux Ubuntu 22.04.4 LTS. Ten esto muy en cuenta porque si usas otra distro, puede que el proceso varíe un poco.

Existen varios clientes de WireGuard disponibles para trabajar con Linux. El mas popular es *wg-quick*. Se trata de una herramienta en linea de comandos que permite configurar y gestionar conexiones WireGuard en sistemas Linux.

Su instalación es muy sencilla, basta con ejecutar este comando:

```
sudo apt install wireguard
```

## Recupera la configuración

Conecta por ssh hasta la máquina Linux donde corres tu servidor de WireGuard. Desde esa máquina, consulta la configuración generada por WireGuard para tu segundo cliente. Para ello, ejecuta este comando:

```
$ docker exec -ti wireguard cat /config/peer2/peer2.conf
```

Fíjate como, en lugar de usar el código QR como hicimos con Android, ahora acabas de recuperar el fichero de configuración generado por el servidor para tu segundo cliente. En tu pantalla veras un listado similar a este:

```
[Interface]
Address = 10.13.13.3
PrivateKey = kG0Nn+ODwopwpveBgw0ok6tF0fP0gGRNoHj1yauqOGQ=
ListenPort = 51820
DNS = 10.13.13.1

[Peer]
PublicKey = GabCBYeijp3LjoTUVMOifYSwfGDWCkggQclanOE/r1A=
PresharedKey = tXYsDXqZNKrR87Kzt+qd6ZdRIuzTA+ybUWRmwu/c4Hs=
Endpoint = TU-PROPIO-HOST:51820
AllowedIPs = 0.0.0.0/0
```

Copia el contenido de este archivo, tal cual, porque lo vas a necesitar.

## Configura el cliente

Ahora regresa al sistema Linux que vas a configurar como cliente. Crea un fichero llamado wg0.conf dentro del directorio /etc/wireguard/.

```
sudo vi /etc/wireguard/wg0.conf
```

En su interior pegas todo el contenido del archivo peer2.conf que has copiado previamente desde tu servidor Linux (donde estas ejecutando tu servidor Wireguard).

## Pasos adicionales

En la máquina Ubuntu donde estoy instalando el cliente de WireGuard, he tenido que instalar el paquete *resolvconf*:

```
$ sudo apt-get install resolvconf
```

Después he tenido que reiniciar el servicio *systemd-resolved* de systemd:

```
$ sudo systemctl start systemd-resolved.service
$ sudo systemctl enable systemd-resolved.service
```

Puede que tu distro ya tenga este paquete instalado y configurado. Dejo anotada esta información por si alguien mas se encuentra con el mismo problema.

## Uso

Para levantar el túnel VPN, haces esto:

```
$ sudo wg-quick up wg0
```

Para consultar el estado del túnel VPN, haces esto:

```
$ sudo wg show
```

Este comando reportará información sobre el interfaz de red wg0 y sobre el servidor al que se encuentra conectado:

```
interface: wg0
  public key: CkZJ3m4giusjgZhJHPnbMxxh8vrLau+9nugQUdpeqgs=
  private key: (hidden)
  listening port: 51820
  fwmark: 0xca6c

peer: GabCBYeijp3LjoTUVMOifYSwfGDWCkggQclanOE/r1A=
  preshared key: (hidden)
  endpoint: hi.dd.e.n:51820
  allowed ips: 0.0.0.0/0
  latest handshake: 17 seconds ago
  transfer: 19.44 MiB received, 3.83 MiB sent
```

Si compruebas la lista de interfaces de red, veras que tienes un interfaz nuevo llamado wg0 configurado:

```
$ ifconfig wg0
wg0: flags=209<UP,POINTOPOINT,RUNNING,NOARP>  mtu 1420
        inet 10.13.13.3  netmask 255.255.255.255  destination 10.13.13.3
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
        RX packets 1164  bytes 501700 (501.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1690  bytes 319280 (319.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```

Ahora ya puedes utilizar todas tus aplicaciones de Linux como de costumbre. La dirección IP de origen de todos los paquetes que acceden a Internet a través de tu túnel VPN ya no es la IP pública asignada por tu ISP local. Ahora es la IP del servidor Linux que has instalado en cualquier parte del mundo. Además, todo el tráfico de datos entre tu PC con Linux y tu servidor VPN estará encriptado.

Por último, para detener el túnel VPN, haces esto:

```
$ sudo wg-quick down wg0
```

# Despedida

En este articulo has aprendido a instalar y configurar un cliente de WireGuard en Linux. Con este articulo cierro la serie de artículos sobre WireGuard.

Espero que esta serie de artículos sobre VPNs en general y WireGuard en particular te hayan resultado de alguna utilidad. Como de costumbre, si tienes cualquier consulta o necesitas más ayuda para instalar WireGuard en tu sistema operativo, no dudes en comentarlo por el [canal de Telegram](https://t.me/lateclaescape). Estaré atento a todos los comentarios.

Espero que disfrutes de tu navegación segura con WireGuard. Úsala con responsabilidad y con sentido común. ¡Nos vemos en el siguiente articulo!

Pulso la tecla ESC, dos puntos wq!
