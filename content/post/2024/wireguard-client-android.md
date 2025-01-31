---
title: Wireguard en Android
date: 2024-04-27
image: /img/posts/wireguard-client-android.webp
categories: ["redes", "cybersecurity"]
tags: ["VPN", "WireGuard", "Android"]
draft: false
featured: true
---

# Introducción

Este articulo explica como instalar, configurar y usar un cliente de [WireGuard](/post/2024/wireguard) en cualquier dispositivo Android. Con esta APP podrás aprovechar todos los [casos de uso](/post/2024/vpn) que tiene navegar por Internet a través de un túnel VPN.

## Pasos previos

En el articulo anterior hemos configurado un [servidor WireGuard](/post/2024/wireguard-server).

Al finalizar el proceso de instalación del servidor, has levantado un contenedor de docker llamado "wireguard" que expone el puerto 51820 UDP. Puedes ver su estado ejecutando este comando:

```
$ docker ps
CONTAINER ID   IMAGE                                    COMMAND                  CREATED       STATUS       PORTS                                                                                NAMES
3dff94957d20   lscr.io/linuxserver/wireguard:latest     "/init"                  2 weeks ago   Up 2 weeks   0.0.0.0:51820->51820/udp, :::51820->51820/udp                                        wireguard
```

Recuerda que al iniciar el servidor de WireGuard, especificaste en su archivo de configuración YAML la variable de entorno PEERS=2 para configurar la conexión de dos clientes. Utilizaremos esta información en breve.

### Instalación en Android

El cliente de WireGuard para Android está disponible de forma gratuita en la tienda de aplicaciones *Play Store* de Google. Abre el *Play Store* en tu dispositivo Android.

Busca una aplicación llamada [WireGuard](https://play.google.com/store/apps/details?id=com.wireguard.android) desarrollada por el *WireGuard Development Team*. Veras que tiene el mismo logotipo que uso en la cabecera de este articulo.

Procede con su descarga e instalación.

Con la APP instalada, podrás importar configuraciones de WireGuard existentes, configurar conexiones nuevas, activar o desactivar la conexión VPN y monitorizar el estado de la misma.

### Configuración

Abre la APP desde tu lista de aplicaciones.

Para configurar el primer cliente que estás dando de alta (PEERS=2), simplemente necesitas importar su configuración. La APP WireGuard para Android facilita este proceso mediante el escaneo de un código QR que contiene toda la información necesaria codificada internamente.

Te conectas por ssh con el servidor Linux donde estas ejecutando el servidor de WireGuard, y ejecutas este comando para obtener la configuración del primer cliente (1):

```
docker exec -it wireguard /app/show-peer 1
```

En tu pantalla verás un código QR como este:

![WireGuard QR-CODE](/img/wireguard-qr.jpg)

En tu APP de Android, toca el botón "+" que aparece en la esquina inferior derecha para añadir una nueva conexión de VPN. Selecciona la opción de "Escanear desde código QR". Procede a escanear este código QR usando tu propio smartphone.

Con esto ya tienes tu primer cliente de WireGuard configurado y listo para funcionar en Android.

### Uso

Ahora verás una lista de todos los túneles disponibles en la pantalla principal de la aplicación. Simplemente toca el interruptor junto al túnel que deseas usar para conectarte al servidor WireGuard configurado.

![WireGuard Android enabled](/img/wireguard-android-enabled.webp)

Verás que el túnel VPN está activo en la barra superior de notificaciones, en la parte derecha junto al icono de cobertura y uso de la batería.

Ahora ya puedes utilizar todas tus aplicaciones de Android como de costumbre. La dirección IP de origen de todos los paquetes que acceden a Internet a través de tu túnel VPN ya no será la IP pública asignada por tu ISP local, sino la IP del servidor Linux que has instalado en cualquier parte del mundo. Además, todo el tráfico de datos entre tu smartphone y tu servidor VPN estará encriptado.

# Despedida

En este articulo has aprendido a instalar y configurar un cliente de WireGuard en Android. En el próximo articulo aprenderás como configurar un cliente de WireGuard en Linux.

Espero que esta información te resulte de utilidad. Si tienes alguna pregunta o necesitas más ayuda, no dudes en comentarlo por el [canal de Telegram](https://t.me/lateclaescape). Como siempre, estaré atento a resolver cualquier duda.

Gracias por leerlo y espero que disfrutes de tu navegación segura con WireGuard. ¡Hasta la próxima!

Pulso la tecla ESC, dos puntos wq!
