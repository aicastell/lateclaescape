---
title: La herramienta docker
date: 2024-04-03
image: "/img/posts/docker.webp"
categories: ["tecnologia", "virtualizacion", "herramientas", "open_source"]
tags: ["docker", "devops", "ci/cd", "contenedores" ]
draft: false
featured: true
---

# Introducción a docker

Hoy es el día. Te has venido arriba. Vas a probar una nueva aplicación de la que te han hablado muy bien. La descargas y la instalas.

Y cuando vas a ejecutarla, te falla.

Descubres que necesita la versión 4.0 de una librería y tu sistema tiene instalada una versión 7.0 mucho mas moderna pero incompatible con la aplicación que quieres probar. Desinstalas la versión 7.0 e instalas la versión 4.0. Vuelves a ejecutar la aplicación.

Sigue sin funcionar. Descubres que está intentando acceder a una base de datos que no tienes instalada. La instalas y vuelves a ejecutar la aplicación.

Vuelve a fallar. Por lo visto, la base de datos necesita unas tablas que no sabes ni lo que son. Te cansas y lo mandas todo a freír espárragos.

Ejecutas tu juego favorito para desconectar. Pero ahora te ha dejado de funcionar. Casualmente estaba usando la librería 7.0 que acabas de desinstalar.

¿Te ha pasado esto alguna vez?. A mi también. Y si, es un dolor de cabeza.

En este articulo te voy a hablar sobre docker, una poderosa herramienta que te ayudará a solucionar todos estos problemas.

## La herramienta docker

Docker es una herramienta de software que permite empaquetar una aplicación y todas sus dependencias, junto con sus ficheros de configuración, para poder ejecutar esa aplicación sobre entornos informáticos heterogéneos, de forma consistente y eficiente.

Trabajando con docker es importante tener claros dos conceptos:

- Imágenes
- Contenedores

### Imágenes docker

El fichero /bin/bash es un binario ejecutable comúnmente utilizado en sistemas Unix y Linux. De manera similar, la imagen de docker es equivalente al binario ejecutable.

Una imagen de docker es una plantilla que contiene los archivos mínimos necesarios para ejecutar una aplicación específica. Esa plantilla incluye los binarios de esa aplicación, sus librerías, y todos sus ficheros de configuración. Esto ayuda a reducir el tamaño de la imagen al mínimo.

Las imágenes de docker son de solo lectura (RO), lo que significa que no se puede cambiar su contenido.

Los desarrolladores pueden crear sus propias imágenes de docker usando ficheros *Dockerfile*. Estos ficheros permiten a cualquier persona reproducir exactamente el mismo entorno de desarrollo, lo que facilita la colaboración y la resolución de problemas. En este articulo no voy a profundizar con los *Dockerfile*. Si alguien tiene especial interés, puedo tratarlo en un articulo posterior.

Existe un repositorio público de imágenes de docker conocido como [DockerHub](https://hub.docker.com/). En DockerHub, los desarrolladores comparten y distribuyen imágenes de docker de manera pública. Se pueden encontrar miles de imágenes prefabricadas de una ingente variedad de aplicaciones como nginx, jenkins, prestashop, postgresql, y prácticamente cualquier cosa que se te ocurra.

Las imágenes de docker actúan como un paquete completo y autónomo que puede ser utilizado para crear instancias ejecutables, proporcionando así un entorno preconfigurado y listo para ser utilizado. Las instancias ejecutables se denominan contenedores de docker. Veamos que son.

### Contenedores docker

Un proceso representa una instancia activa de un archivo binario en ejecución. Al usar el comando 'ps', podemos observar varios procesos de bash en ejecución. De manera similar, un contenedor de docker se asemeja a este proceso en ejecución, ya que encapsula la ejecución de una aplicación específica en un entorno aislado y controlado.

Un contenedor de docker es una instancia de una imagen de docker en ejecución.

Un contenedor de docker proporciona un entorno aislado para ejecutar una imagen de docker. Esto significa que las dependencias de la aplicación no interferirán con otras aplicaciones que corren en tu sistema. De esta manera se elimina el riesgo de conflictos entre versiones de bibliotecas, lo que garantiza que la aplicación se ejecute de manera predecible y sin sorpresas.

El contenedor es una capa adicional de lectura/escritura (RW) situada sobre la capa RO de la imagen. Es la capa donde se ejecuta todo (se crean logs, se instalan o borran ficheros, se generan resultados, etc). Los cambios en el contenedor son temporales, se pierden tan pronto muere el contenedor.

> Everything in Google runs in a container.

Éstas fueron las palabras citadas en Mayo de 2014 por [Joe Beda](https://www.linkedin.com/in/jbeda/), por aquel entonces ingeniero de software senior en Google, en una conferencia donde explicó que Google corría 2 billones de contenedores de docker cada semana. Este dato demuestra la intensa adopción de docker por parte de un gigante tecnológico como Google en todos sus servicios.

## Maquinas virtuales

He hablado con muchas personas que confunden las máquinas virtuales con docker. Y no, docker no es una maquina virtual. Son cosas muy diferentes. Voy a intentar explicar la diferencia.

Por encima del hardware siempre tenemos corriendo a nuestro querido sistema operativo Linux. Hasta aquí nada nuevo.

Cuando usamos maquinas virtuales (virtualbox, vmware o KVM), por encima de Linux corre una capa de software llamada **monitor de máquinas virtuales** (VMM). Sobre el VMM corren los distintos sistemas operativos virtualizados. Cada uno de ellos necesita una instalación completa del sistema operativo, reservando una cantidad ingente de recursos, tanto de disco duro como de memoria RAM.

Cuando usamos docker, por encima de Linux corre el **Docker Engine**, un proceso mas del sistema operativo sobre el cual se ejecutan directamente los contenedores. Lo cual hace que los recursos consumidos (tanto de disco duro como de memoria RAM) sean muy inferiores. Y por tanto docker aproveche mucho mejor los recursos que una máquina virtual. Al ser mucho mas liviano, se pueden correr muchos mas contenedores que máquinas virtuales, mejorando la utilización de los recursos hardware.

## Instalación de docker

La instalación de docker puede hacerse de muchas maneras. Voy a dejar documentada la que yo uso para instalar la última versión oficial:

Antes de empezar, desinstala cualquier residuo de docker de tu sistema operativo.

```
$ for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

Descarga el instalador (script get-docker.sh):

```
$ curl -fsSL https://get.docker.com -o get-docker.sh
```

Ejecuta el instalador:

```
$ sudo sh get-docker.sh
```

Crear el grupo docker:

```
$ sudo groupadd docker
```

Añade tu usuario al grupo docker:

```
$ sudo usermod -aG docker $USER
```

Ejecuta este comando para aplicar los cambios del nuevo grupo recién creado:

```
$ newgrp docker
```

Con esto ya podrás ejecutar comandos de docker sin tener que usar el comando "sudo" cada vez que los ejecutas.

Verifica que funciona todo bien:

```
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c1ec31eb5944: Pull complete
Digest: sha256:53641cd209a4fecfc68e21a99871ce8c6920b2e7502df0a20671c6fccc73a7c6
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```

Con este comando acabas de descargar una imagen de docker llamada "hello-world" y de crear un contenedor con esa imagen que muestra por pantalla el mensaje que acabas de ver. Enhorabuena, ya tienes docker funcionando en tu sistema.

## Despedida

En este articulo has aprendido que es la herramienta docker, que son las imágenes, y qué son los contenedores. También has aprendido la diferencia entre docker y las máquinas virtuales. Y por último, has aprendido a instalar la herramienta docker.

Es una herramienta muy útil como veremos en artículos posteriores. Espero que el articulo te resulte útil y te animes a investigar mas sobre posibles usos que puedas darle a esta herramienta.

Cualquier duda sobre posibles usos, sobre la instalación, o incluso cualquier sugerencia, podéis contactar conmigo por el [canal de Telegram](https://t.me/lateclaescape). Nos vemos en el próximo articulo.

Pulso la tecla ESC, dos puntos wq!
