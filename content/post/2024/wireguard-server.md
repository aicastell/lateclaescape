---
title: Servidor Wireguard
date: 2024-04-20
image: /img/posts/wireguard-server.webp
tags: [ "VPN", "WireGuard" ]
categories: [ "redes" ]
draft: false
featured: true
---

# Motivación

En artículos anteriores de este blog he hablado sobre [redes VPN](/posts/vpn) y sobre [WireGuard](/posts/wireguard). Si no has leído los artículos referenciados, te recomiendo su lectura antes de continuar leyendo.

Ahora que ya sabes lo que es un túnel VPN y para qué sirve, y que sabes que WireGuard es un servidor VPN seguro, liviano y muy rápido, es momento de avanzar.

En este articulo explico como instalar el servidor WireGuard en un servidor Linux.

Para no alargar en exceso este articulo, asumiré que tienes acceso por ssh a un servidor Linux alojado en cualquier país lejos del territorio de tu país. Si no sabes como hacer esto, coméntalo en el [canal de Telegram](https://t.me/lateclaescape) y haré un articulo específico para esta cuestión.

## Instalación

El primer paso es conectar por ssh al servidor Linux alojado fuera de España.

La manera mas sencilla y práctica de instalar un servidor de WireGuard es usando la herramienta docker, de la que ya hemos hablamos en un articulo anterior. A continuación, [instala docker](/posts/herramienta-docker) siguiendo la guía paso a paso referenciada.

Crea un fichero YAML llamado *docker-compose.yaml* con este contenido (copia y pega):

```
$ mkdir -p /home/<user>/vpn/
$ cd /home/<user>/vpn/
$ cat docker-compose.yaml
---
services:
  wireguard:
    image: lscr.io/linuxserver/wireguard:latest
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Madrid
      - SERVERURL=TU-PROPIO-HOST
      - SERVERPORT=51820 #optional
      - PEERS=2 #optional
      - PEERDNS=auto #optional
      - INTERNAL_SUBNET=10.13.13.0 #optional
      - ALLOWEDIPS=0.0.0.0/0 #optional
      - PERSISTENTKEEPALIVE_PEERS= #optional
      - LOG_CONFS=true #optional
    volumes:
      - /home/USUARIO/vpn/config:/config
      - /lib/modules:/lib/modules #optional
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
```

Este fichero YAML da instrucciones claras y precisas a docker sobre los pasos que debe seguir para arrancar el servidor de WireGuard.

El apartado *image* indica que debe bajarse la última imagen de docker de WireGuard, que está disponible en el servidor *lscr.io/linuxserver/wireguard*.

El apartado *container_name* indica que debe levantar un contenedor de docker llamado "wireguard".

El apartado *environment* define unas variables de entorno que controlan el arranque de WireGuard como servidor. En este apartado hay dos variables que hay que configurar: PEERS y SERVERURL.

La variable *PEERS* indica el numero de clientes a los que el servidor WireGuard dará servicio. El valor 2 indica que atenderá a dos clientes. Por tanto, se van a generar claves publicas y privadas, así como archivos de configuración, para 2 clientes. Ajusta el valor de la variable PEERS a tus propias necesidades.

La variable *SERVERURL* indica la dirección IP pública de tu servidor Linux (si tienes IP estática), o su nombre DNS (si tienes IP dinámica). El valor *TU-PROPIO-HOST* es solo un ejemplo. Personaliza su valor para adaptarlo a tus propias necesidades particulares.

El apartado *volumes* define los directorios de tu servidor que se van a montar como volumen para su uso dentro del contenedor. Cambia /home/USUARIO/vpn/config por el path que necesites. En ese directorio se guardará toda la configuración de tu servidor WireGuard.

Con esto es mas que suficiente para levantar el servidor WireGuard. Si sientes curiosidad por el resto de las opciones, puedes encontrar la lista completa de parámetros con su significado en [este enlace](https://github.com/linuxserver/docker-wireguard).

A continuación utilizas el plugin *compose* de docker para levantar el contenedor de WireGuard. Esto se hace ejecutando el siguiente comando:

```
$ docker compose up -d wireguard
```

Al finalizar el proceso, habrás levantado un contenedor de docker llamado "wireguard" que expone el puerto 51820 UDP. Puedes verlo corriendo ejecutando este comando:

```
$ docker ps
CONTAINER ID   IMAGE                                    COMMAND                  CREATED       STATUS       PORTS                                                                                NAMES
3dff94957d20   lscr.io/linuxserver/wireguard:latest     "/init"                  2 weeks ago   Up 2 weeks   0.0.0.0:51820->51820/udp, :::51820->51820/udp                                        wireguard
```

Enhorabuena, ya tienes tu servidor de VPN WireGuard funcionando en tu servidor Linux. Ahora lo que tienes que hacer es configurar tus dispositivos clientes para usarlo. Veremos esta cuestión en los próximos articulos.

# Despedida

En este articulo has aprendido a instalar un servidor de WireGuard en un servidor Linux de tu propiedad. En próximos artículos aprenderás a configurar un cliente de WireGuard en Android y en Linux.

Espero que encuentres el contenido interesante. Si tienes preguntas o comentarios, no dudes en plantearlos en el [canal de Telegram](https://t.me/lateclaescape). Todos los artículos publicados se intentan mantener actualizados. Si hay algún detalle que creas que falta, estoy abierto a añadirlo. Así lograremos que estos artículos sean útiles para más personas. ¡Gracias por leerme y nos vemos en el próximo artículo!.

Pulso la tecla ESC, dos puntos wq!
