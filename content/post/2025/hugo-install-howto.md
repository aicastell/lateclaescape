---
title: Instalación de Hugo
date: 2025-08-03
image: /img/posts/hugo-install-howto.webp
categories: [ "framework" ]
tags: [ "hugo", "howto", "libsass" ]
draft: false
featured: true
---

# Introducción

[Hugo](/post/2025/framework-hugo) es uno de los frameworks para generar sitios web estáticos más rápidos, versátiles y populares del ecosistema actual.

Aunque puedes instalar Hugo desde los paquetes oficiales disponibles en los repositorios de Linux, suelen estar desactualizados. Compilar el framework desde el código fuente ofrece varias ventajas: tienes disponible la última versión estable, puedes elegir entre la versión estándar o la extendida, no dependes de paquetes desactualizados de tu sistema operativo, y además es una excelente oportunidad para aprender.

En este artículo te explico cómo instalar Hugo de la forma correcta, moderna y limpia, para que tengas la última versión del framework lista para trabajar.

# Requisitos

Para compilar la herramienta hugo, necesitas tener instalado el compilador del lenguaje [Golang](/post/2025/golang-language) en tu PC. Si todavía no lo tienes instalado, es el momento adecuado para leerte [este tutorial](/post/2025/golang-install-howto) que explica como instalarlo y configurarlo.

El comando *go install* instala los binarios generados en el directorio *$HOME/go/bin*. Este path es un estándar de facto en Go, y no se recomienda cambiarlo a menos que tengas motivos de peso. Para que Linux encuentre los binarios instados en este directorio, es necesario que lo añadas a tu variable de entorno PATH, de esta manera:

```
export PATH=$PATH:$HOME/go/bin
```

Pero este comando se pierde cuando reinicias tu PC o abres un nuevo terminal.

Para que esta variable PATH esté siempre disponibles en tu sistema cada vez que arranques tu PC, o cada vez que abras una nueva terminal, edita el fichero de configuración de tu shell:

```
$ vi ~/.bashrc
```

Y añade al final del fichero esta linea:

```
export PATH=$PATH:$HOME/go/bin
```

Guarda los cambios y sal del editor.

Para aplicar estos cambios en la sesión actual de tu terminal, ejecuta este comando:

```
$ source ~/.bashrc
```

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
$ go install github.com/gohugoio/hugo@latest
```

El comando go install descarga el código fuente desde el repositorio de GitHub, lo compila y guarda el binario resultante en el directorio *$HOME/go/bin*.

## Hugo extended

La versión extendida de Hugo incluye funcionalidades adicionales pensadas para proyectos web modernos. Una de sus principales ventajas es el soporte para procesar estilos CSS avanzados mediante herramientas como PostCSS y SCSS/SASS.

SASS (Syntactically Awesome Stylesheets) y SCSS (Sassy CSS) son lenguajes que amplían las capacidades de CSS. Permiten escribir estilos de forma más estructurada, reutilizable y organizada. No voy a profundizar más para no desviar el enfoque del artículo, pero debes saber que muchas plantillas modernas de Hugo los utilizan.

Este soporte es posible gracias a la integración de la biblioteca libsass, que permite compilar SCSS/SASS a CSS de forma eficiente, sin necesidad de instalar Node.js. Aunque libsass ya no se mantiene activamente, sigue siendo utilizada por proyectos como Hugo por su rapidez y simplicidad.

Para compilar e instalar Hugo Extended desde el código fuente, necesitas instalar en tu PC las herramientas de compilación de C/C++.

```
$ sudo apt install git make gcc g++
```

Después ya puedes proceder con la instalación de Hugo extended:

```
$ CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
```

El comando go install descarga el código fuente desde el repositorio de GitHub, lo compila y guarda el binario resultante en el directorio *$HOME/go/bin*.

La opción -tags extended indica que quieres compilar la variante extendida.

La variable CGO_ENABLED=1 es necesaria para que Go pueda compilar y enlazar el código en C/C++ de la biblioteca libsass, que Hugo utiliza para procesar SCSS y SASS. Al activarla, necesitas tener instaladas previamente herramientas como gcc, g++ y make, ya que son imprescindibles para compilar el código nativo de la librería libsass correctamente.

# Verificar instalación

Verifica que tu sistema es capaz de encontrar el binario hugo:

```
$ which hugo
/home/user/go/bin/hugo
```

Y verifica que hugo se haya instalado correctamente en tu sistema:

```
$ hugo version
hugo v0.148.1+extended linux/amd64 BuildDate=unknown
```

Si has elegido el mismo camino que yo, instalando la versión extendida, verás que aparece la palabra "extended" en la salida reportada.

Ya tienes Hugo compilado, instalado y listo para funcionar. Todo un éxito, ¿no te parece?.

# Despedida

Este artículo muestra que compilar Hugo desde su código fuente es muy sencillo, siempre que ya tengas Go instalado. Esta forma de instalación te da un control total sobre la versión de Hugo que usas, y te permite una visión más profunda del proceso de compilación del framework.

Si te ha picado la curiosidad, te han surgido dudas, o simplemente quieres contarme que has empezado a investigar sobre este framework, puedes unirte de forma totalmente gratuita al [canal de Telegram](https://t.me/lateclaescape). Allí puedes dejarme tus preguntas, sugerencias, críticas (mejor si son constructivas)... o simplemente pasarte a saludar.

En el próximo artículo te enseñaré [cómo crear tu primer website con Hugo](/post/2025/hugo-helloworld-howto). ¡Nos vemos en el próximo articulo!

Pulso la tecla ESC, dos puntos wq!
