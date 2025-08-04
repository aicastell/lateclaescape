---
title: Instalación de Hugo
date: 2025-08-03
image: /img/posts/hugo-install-howto.webp
categories: [ "framework" ]
tags: [ "hugo", "howto", "libsass" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/hugo-install-howto.mp3" >}}

# Introducción

El [framework Hugo](/post/2025/framework-hugo) es uno de los generadores de sitios estáticos más rápidos y versátiles del panorama actual.

Podrías instalar Hugo desde los paquetes oficiales disponibles en los repositorios de Linux, pero suelen estar desactualizados. Compilar el framework desde el código fuente ofrece varias ventajas: te da un control total sobre la versión que usas, te permite incorporar rápidamente las mejoras de la comunidad, te brinda la opción de modificar el código a tu gusto y, además, es una excelente oportunidad para aprender.

En este artículo te explico cómo descargar el código fuente del proyecto, compilarlo tú mismo e instalarlo para tener la última versión del framework lista para trabajar.

# Requisitos

Antes de empezar, asegúrate de seguir [este tutorial](/post/2025/golang-install-howto) que explica cómo instalar y configurar Go. Es esencial antes de continuar.

## Dependencias

Debes tener instaladas algunas herramientas que usaré sin explicar como funcionan. Simplemente espera a que finalice la ejecución de este comando:

```
sudo apt install git make gcc g++
```

## Variables de entorno

### GOPATH

La variable de entorno GOPATH le dice a Go dónde guardar el código fuente de tus proyectos en Go y las dependencias que se descarga. Puedes definirla de esta manera:

```
export GOPATH=$HOME/Documentos/go
```

### GOBIN

Es una buena práctica que los binarios instalados con Go se guarden en el directorio $GOPATH/bin. Por tanto, define la variable de entorno GOBIN para asegurarte de que se instalan ahí:

```
export GOBIN=$GOPATH/bin
```

A partir de este momento, los binarios instalados (comando go install), terminarán guardados en el directorio $HOME/Documentos/go/bin.

### PATH

Asegúrate de que la variable de entorno GOBIN esté en tu PATH, para poder ejecutar los binarios de Go desde cualquier directorio de tu sistema operativo:

```
export PATH=$PATH:$GOBIN
```

### Persistencia

Para que estas variables estén siempre disponibles en tu sistema, sigue estos pasos:

Edita el fichero de configuración de tu shell:

```
$ vi ~/.bashrc
```

Y añade al final del fichero estas 3 lineas:

```
export GOPATH=$HOME/Documentos/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
```

Guarda los cambios y sal del editor.

Después recarga el contenido de este fichero para aplicar los cambios en tu terminal actual:

```
$ source ~/.bashrc
```

A partir de ahora, estas tres variables estarán disponibles tanto en esta sesión como en cualquier terminal nuevo que abras.

# El código fuente de Hugo

El repositorio del código fuente de Hugo se aloja en [este proyecto](https://github.com/gohugoio/hugo) de github.

Existen dos versiones de hugo:

- Hugo standard
- Hugo extended

La versión recomendada en la propia documentación es la extendida. Sin embargo, te explicaré la manera de instalar ambas versiones:

## Hugo standard

La versión estándar de Hugo no tiene soporte SCSS ni SASS. Es suficiente para la mayoría de proyectos que no requieren procesamiento avanzado de estilos CSS o JS.

La descarga de los fuentes, la compilación y la instalación de Hugo estándar se realiza con este comando, que puedes copiar y pegar directamente en tu terminal:

```
go install github.com/gohugoio/hugo@latest
```

El comando go install descarga el código fuente desde el repositorio de GitHub, lo compila y guarda el binario resultante en el directorio definido por la variable GOBIN. No profundizaré aquí en su funcionamiento, ya que se trata de un tema específico del lenguaje Go que abordaremos en una serie de artículos dedicados a Go más adelante.

## Hugo extended

La versión extendida de Hugo incluye funcionalidades adicionales pensadas para proyectos web modernos. Una de sus principales ventajas es el soporte para procesar estilos CSS avanzados mediante herramientas como PostCSS y SCSS/SASS.

SASS (Syntactically Awesome Stylesheets) y SCSS (Sassy CSS) son lenguajes que amplían las capacidades de CSS. Permiten escribir estilos de forma más estructurada, reutilizable y organizada. No voy a profundizar más para no desviar el enfoque del artículo, pero debes saber que muchas plantillas modernas de Hugo los utilizan.

Este soporte es posible gracias a la integración de la biblioteca libsass, que permite compilar SCSS/SASS a CSS de forma eficiente, sin necesidad de instalar Node.js. Aunque libsass ya no se mantiene activamente, sigue siendo utilizada por proyectos como Hugo por su rapidez y simplicidad.

Para compilar e instalar Hugo Extended desde el código fuente, ejecuta este comando en tu terminal:

```
CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
```

La opción -tags extended indica que quieres compilar la variante extendida.

La variable CGO_ENABLED=1 es necesaria para que Go pueda compilar y enlazar el código en C/C++ de la biblioteca libsass, que Hugo utiliza para procesar SCSS y SASS. Al activarla, necesitas tener instaladas previamente herramientas como gcc, g++ y make, ya que son imprescindibles para compilar el código nativo de la librería libsass correctamente.

No quiero entrar en muchos detalles sobre Go, ya que me gustaría dedicar artículos específicos para este lenguaje.

# Verificar instalación

Verifica que tu sistema es capaz de encontrar el binario hugo:

```
$ which hugo
/home/user/Documentos/go/bin/hugo
```

Y verifica que hugo se haya instalado correctamente en tu sistema:

```
$ hugo version
hugo v0.148.1+extended linux/amd64 BuildDate=unknown
```

Si has elegido el mismo camino que yo, instalando la versión extendida, verás que aparece la palabra "extended" en la salida reportada.

¡Ya tienes Hugo compilado con éxito!

# Despedida

Este artículo muestra que compilar Hugo desde su código fuente es muy sencillo, siempre que ya tengas Go instalado. Esta forma de instalación te da un control total sobre la versión de Hugo que usas, y te permite una visión más profunda del proceso de compilación del framework.

Si te ha picado la curiosidad, te han surgido dudas, o simplemente quieres contarme que has empezado a investigar sobre este framework, puedes unirte de forma totalmente gratuita al [canal de Telegram](https://t.me/lateclaescape). Allí puedes dejarme tus preguntas, sugerencias, críticas (mejor si son constructivas)... o simplemente pasarte a saludar.

En el próximo artículo te enseñaré cómo utilizar la herramienta hugo para crear tu primer website. ¡Nos vemos en el próximo articulo!

Pulso la tecla ESC, dos puntos wq!
