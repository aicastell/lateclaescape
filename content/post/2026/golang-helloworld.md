---
title: Hola Mundo en Go
date: 2026-01-04
image: /img/posts/golang-helloworld.webp
categories: [ "programming_language" ]
tags: [ "golang", "howto" ]
draft: false
featured: true
---

# Introducción

El lenguaje de programación [Golang](/post/2025/golang-language) ha calado con fuerza entre desarrolladores que buscan simplicidad, rendimiento y concurrencia eficiente, sin arrastrar la complejidad de otros ecosistemas mas antiguos.

En un artículo previo expliqué como [instalar go en Linux](/post/2025/golang-install-howto). En este articulo damos el siguiente paso natural: analizar en profundidad un "Hello World" en Go.

El objetivo no es solo mostrar un mensaje por pantalla, sino empezar a comprender como funciona Go desde dentro. Como se organiza el código, cómo se ejecuta, y que papel juegan las herramientas del lenguaje incluso en el ejemplo mas simple.

Si quieres aprender a programar en Go, te animo a acompañarme en la lectura de esta serie de artículos donde vas a aprender Go desde los cimientos de este lenguaje. Vamos con ello.

# Verifica la instalación de Go

Antes de empezar, asegúrate de que Go está correctamente instalado y accesible desde tu terminal:

```
$ go version
go version go1.24.5 linux/amd64
```

Si ves una salida similar, todo ha ido bien y puedes continuar. Este comando ya nos adelanta varias cosas importantes:

- Go es una herramienta auto-contenida (go).
- El compilador, el enlazador y el gestor de módulos vienen integrados.
- La arquitectura objetivo (linux/amd64) se detecta automáticamente.

# Prepara el entorno de trabajo

Crea un directorio de trabajo para este nuevo proyecto:

```
$ mkdir hello-go
$ cd hello-go
```

Go no impone una estructura rígida para proyectos pequeños, pero trabajar en un directorio dedicado es una buena práctica desde el principio. A medida que el proyecto crezca, este directorio contendrá código, módulos, dependencias y binarios.

# El código fuente

Abre tu editor de texto favorito (ya sabemos todos que el mejor editor del mundo mundial es vim) y crea un archivo llamado *main.go* con el siguiente contenido:

```
$ cat main.go
package main

import "fmt"

func main() {
    fmt.Println("Hola, mundo")
}
```

Este es el programa más simple que se puede escribir en Go y que genera un binario ejecutable.

# El contexto de ejecución

En Go moderno el código nunca vive aislado. Todo programa pertenece a un módulo, incluso el hello world. El módulo es la unidad básica que Go utiliza para:

- Dar contexto al compilador y al enlazador.
- Resolver dependencias.
- Determinar el nombre del binario resultante.
- Definir la versión del lenguaje esperada.

Por eso, antes de ejecutar el código, debemos inicializar el módulo del proyecto. Lo haremos así:

```
$ go mod init hello-go
```

Esto crea un archivo *go.mod* con este contenido:

```
$ cat go.mod
module hello-go

go 1.24
```

Este archivo define dos cosas fundamentales:

- El nombre del módulo (hello-go), que actúa como identificador lógico del proyecto.
- La versión mínima de Go con la que se espera compilar este código.

El sistema de módulos es uno de los grandes aciertos de Go: elimina rutas mágicas, variables de entorno complejas y dependencias globales compartidas entre proyectos.

# Ejecutando el programa

Ahora que el código ya tiene un contexto válido, podemos ejecutarlo.

```
$ go run .
```

Este comando hace varias cosas por ti:

- Analiza el módulo actual.
- Compila el código fuente en un binario temporal.
- Ejecuta ese binario.
- Limpia los artefactos intermedios al finalizar.
- No deja ningún ejecutable persistente en disco. Es ideal para pruebas rápidas y desarrollo.

El resultado será el esperado:

```
Hola, mundo
```

El comando *go run* es ideal para desarrollo y pruebas rápidas, ya que no deja ningún ejecutable persistente en disco.

# Compilando un binario ejecutable

Si prefieres generar un binario real, utiliza:

```
$ go build
```

Esto crea un ejecutable en el directorio actual.

Un detalle importante es que el nombre del binario se deriva del nombre del módulo, no del archivo fuente. En este caso:

```
$ ./hello-go
Hola, mundo
```

Esto refleja una convención clave de Go: el ejecutable representa al módulo completo, no a un archivo concreto.

Con esto, ya tienes tu primer programa en Go compilado y funcionando como un binario listo para distribuir. Este binario es auto-contenido. Puedes copiarlo a otra máquina sin Go instalado y funcionará.

# Análisis linea a linea

Ahora que el programa ya se ha ejecutado y sabemos qué hace, vamos a analizar con calma qué significa cada una de sus líneas y por qué Go exige exactamente esta estructura.

## El paquete main

```
package main
```

La directiva `package` es una palabra clave del lenguaje Go que indica a qué paquete pertenece un archivo fuente (con extensión .go). Debe aparecer obligatoriamente como la primera instrucción ejecutable del archivo, precedida únicamente, si los hubiera, por comentarios o directivas de compilación.

En Go, todos los archivos fuente que se encuentran dentro de un mismo directorio deben declarar exactamente el mismo nombre de paquete. No está permitido mezclar diferentes paquetes en un mismo directorio. Por convención y buena práctica, el nombre del paquete suele coincidir con el nombre del directorio que lo contiene, aunque el compilador no exige esta coincidencia de forma estricta.

Cada directorio del sistema de archivos representa un único paquete Go. No es posible dividir un mismo paquete entre varios directorios, ni siquiera utilizando subdirectorios. Cada subdirectorio define siempre un paquete distinto e independiente. Estos paquetes pueden estar relacionados jerárquicamente mediante su ruta de importación. Por ejemplo, los directorios auth/ y auth/jwt/ corresponden a dos paquetes diferentes: auth y jwt, cuyas rutas de importación completas serían tumodulo/auth y tumodulo/auth/jwt, respectivamente.

El paquete especial `main` tiene un propósito específico: la construcción de programas ejecutables. Todo programa ejecutable escrito en Go debe contener exactamente un paquete llamado `main`. Si un conjunto de archivos Go no declara un paquete `main` el código podrá compilarse como librería, pero no podrá producir un binario ejecutable.

Esta organización estricta basada en paquetes y directorios es un pilar fundamental del diseño de Go: proporciona claridad estructural, evita ambigüedades y refuerza la modularidad y mantenibilidad del código.

## Importar una librería

```
import "fmt"
```

La directiva `import` es una palabra clave de Go que indica al compilador qué paquetes externos serán utilizados desde el archivo actual. En este caso, `import "fmt"` importa el paquete `fmt`, que forma parte de la biblioteca estándar de Go.

El paquete `fmt` proporciona funciones para formateo e impresión de datos, especialmente orientadas a la entrada y salida estándar (I/O).

Algunas reglas importantes relacionadas con import:

- Go no permite imports no utilizados: si se importa un paquete que no se usa, el compilador producirá un error.
- Las rutas de importación se expresan como cadenas entre comillas dobles.
- El compilador y el enlazador solo incluyen en el binario final el código que realmente se utiliza.

Aunque fmt es un paquete amplio, el binario generado incluirá únicamente las funciones necesarias. Este diseño contribuye a mantener binarios compactos y eficientes.

## Función main

```
func main() { ... }
```

La función `main` es la función principal del paquete main y constituye el punto de entrada del programa. Es la primera función que se ejecuta cuando el binario resultante se lanza.

La función se define mediante la palabra reservada `func`. Los paréntesis vacíos () indican que la función no recibe parámetros. El cuerpo de la función, delimitado por llaves {}, contiene las instrucciones que se ejecutarán cuando el programa arranque.

Antes de ejecutar la función `main`, Go ha preparado completamente el entorno de ejecución. En particular:

- Ha inicializado el runtime.
- Ha arrancado el planificador de goroutines.
- Ha preparado el recolector de basura.
- Ha inicializado todas las variables globales.
- Ha ejecutado todas las funciones init() definidas en los paquetes importados.

La función `main` tiene varias restricciones importantes:

- No recibe argumentos directamente (los argumentos de línea de comandos se acceden mediante os.Args).
- No devuelve ningún valor.
- El código de salida del programa se controla mediante os.Exit.

Cuando la función `main` finaliza su ejecución, el programa termina.

## Imprimir el mensaje

```
fmt.Println("Hello, world")
```

Esta línea invoca la función `Println` definida en el paquete `fmt` previamente importado. Su comportamiento es el siguiente:

- Imprime el texto indicado en la salida estándar (stdout).
- Añade automáticamente un salto de línea al final.
- Maneja correctamente cadenas en formato UTF-8.
- Es segura para concurrencia, por lo que puede utilizarse desde múltiples goroutines.

Aunque el ejemplo es mínimo, el binario generado incluye el runtime completo de Go: recolector de basura, planificador, soporte de concurrencia, Unicode y otras capacidades básicas. Por este motivo, un programa “Hello, world” en Go suele ocupar entre 2 y 4 MB.

Este tamaño no implica código innecesario: el resultado es un binario auto-contenido, preparado para ejecutarse en otros equipos sin instalar dependencias externas.

# Despedida

Este es el primer artículo de una serie dedicada a Go. Este lenguaje no se aprende memorizando trucos, sino entendiendo cómo encajan sus piezas desde el principio.

Los próximos artículos irán introduciendo, paso a paso, los distintos elementos del lenguaje: tipos de datos, estructuras de control, paquetes, módulos, concurrencia, interfaces, testing y despliegue, siempre con ejemplos prácticos y reales.

Has empezado un nuevo viaje. El código ya compila. Pero ahora toca profundizar hasta convertirte en un auténtico profesional del desarrollo de software con este lenguaje.

Si te interesa este contenido, no dudes en comentarlo en el [canal de Telegram](https://t.me/lateclaescape), en la medida de mis posibilidades, intentaré priorizar los temas que generen un mayor interés.

Prepara tu terminal para seguir aprendiendo Go. ¡Nos vemos en el próximo artículo!.

Pulso la tecla `ESC:wq!`
