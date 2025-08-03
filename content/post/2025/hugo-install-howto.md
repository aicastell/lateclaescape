---
title: Instalación de Hugo
date: 2025-08-03
image: /img/posts/hugo-install-howto.webp
categories: [ "framework" ]
tags: [ "hugo", "howto" ]
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

A partir de este momento, los binarios instalados con el comando go install, terminarán guardados en el directorio $HOME/Documentos/go/bin.

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

El comando go install descarga los fuentes del repositorio de github, los compila y los instala en tu directorio GOBIN.

## Hugo extended

La versión extendida de Hugo es una versión mejorada que incluye soporte adicional para herramientas de desarrollo web modernas, especialmente para la transformación de CSS con PostCSS y SCSS/SASS. Esto se consigue a través de la librería libsass.

La descarga de los fuentes, la compilación y la instalación de Hugo extended se realiza con este comando, que puedes copiar y pegar directamente en tu terminal:

```
CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
```

Fíjate que el flag -tags habilita la variante extended.

SASS (Syntactically Awesome Stylesheets) y SCSS (Sassy CSS) son lenguajes que extienden CSS (Cascading Style Sheets). Te permiten escribir estilos de forma más poderosa, limpia y organizada. No voy a entrar en los detalles para no desviar la atención de este documento.

libsass es una biblioteca escrita en C/C++ que se encarga de compilar SCSS/SASS a CSS. Es rápida y estuvo muy de moda porque al estar escrita en C es muy eficiente, y permite usar SCSS sin necesidad de instalar node.js. Hoy en día no se mantiene de forma activa, pero muchos proyectos como Hugo la siguen usando.

Para poder utilizar la librería libsass, es necesario definir la variable CGO_ENABLED=1 para indicar al compilador de Go que tu proyecto usa funciones escritas en C. Para que esto funcione, has instalado previamente el compilador de C (gcc y g++) y la herramienta make para automatizar tareas de compilación.

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

En el próximo artículo te enseñaré cómo crear un "Hello World" con Hugo. ¡Nos vemos en el próximo articulo!

Pulso la tecla ESC, dos puntos wq!
