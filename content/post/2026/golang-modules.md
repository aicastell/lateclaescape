---
title: Módulos en Go
date: 2026-01-05
image: /img/posts/golang-modules.webp
categories: [ "programming_language" ]
tags: [ "golang", "howto" ]
draft: true
featured: true
---

# Introducción

Uno de los problemas históricos del desarrollo de software ha sido el de organizar el código y gestionar sus dependencias de forma fiable. Rutas mágicas, variables de entorno, gestores externos, conflictos de versiones y el clásico *en mi máquina funciona* han sido la pesadilla de generaciones.

Go nació con un objetivo claro: eliminar esa complejidad desde la raíz. Ese objetivo se alcanzó plenamente a partir de Go 1.16 con la introducción del `sistema de módulos`, que hoy es el pilar central de la organización de proyectos en Go.

Este articulo explica qué es un `módulo` en Go, por qué existe, qué problemas resuelve y cómo garantiza que un proyecto sea reproducible, verificable y mantenible en el tiempo. Si estás aprendiendo Go en serio, entender los módulos no es opcional. Así que presta atención, porque lo que voy a explicar, también te interesa.

# Módulos en Go

Un `módulo` es la unidad fundamental de organización, versionado y distribución en Go. En términos prácticos, un módulo representa un proyecto completo.

En Go no existe el código “huérfano”: todo el código vive siempre dentro del contexto explícito de un módulo. Incluso el programa más sencillo, como el clásico [Hello World](/post/2026/golang-helloworld), debe pertenecer a uno.

Un módulo define, de forma clara y sin ambigüedades:

- El **nombre** con el que se identifica el proyecto.
- La **versión mínima de Go** con la que debe compilarse.
- Qué **código fuente** forma parte del proyecto.
- Qué **dependencias externas** utiliza y las **versiones exactas** de cada una.
- Las reglas necesarias para garantizar **builds reproducibles**.

Por esta razón, en la práctica se cumple que:

> un proyecto Go = un módulo Go

# El archivo go.mod

Todo módulo Go está definido por un archivo llamado `go.mod`, situado en el directorio raíz del proyecto. En el articulo sobre el [Hello World](/post/2026/golang-helloworld) creamos el módulo mas básico posible:

```
$ cat go.mod
module hello-go

go 1.24
```

Este archivo contiene dos elementos clave:

- El nombre del módulo
- La versión de Go

## El nombre del módulo

El nombre del módulo es un **identificador lógico y global** que representa a tu proyecto dentro del ecosistema de Go.

```
module hello-go
```

No es obligatorio que coincida con el nombre del directorio ni con el del binario, aunque por convención, suele hacerse así. En proyectos reales, especialmente si se publican en internet, el nombre del módulo suele adoptar la forma de una **URL canónica**:

```
module github.com/usuario/hello-go
```

El nombre cumple tres funciones principales:

- Identidad pública y dependencias
- Nombre del binario ejecutable
- Unicidad global

### Identidad publica y dependencias

El nombre del módulo es la identidad global de tu proyecto. Es el dato que otros desarrolladores usan para consumir tu código.

Cuando alguien ejecuta:

```
$ go get github.com/aicastell/calculadora@latest
```

Go interpreta ese nombre como una ubicación resoluble. Siguiendo convenciones bien definidas, intenta obtener el código desde:

```
https://github.com/aicastell/calculadora
```

Si el repositorio existe:

- Descarga el código.
- Resuelve versiones.
- Verifica integridad.
- Registra la dependencia de forma reproducible.

El nombre del módulo es, por tanto, una dirección global, una interfaz pública y un contrato estable. Puedes reorganizar el código internamente (cambiar directorios, nombre o rutas de ficheros) sin romper a los consumidores, siempre que el nombre del módulo permanezca intacto.

### Determinar el nombre del binario ejecutable

Cuando tu módulo contiene un programa ejecutable (es decir, un `package main`), el comando `go build` no genera un binario llamado main, sino que usa el último segmento del nombre del módulo como nombre del binario ejecutable. Vemos algunos ejemplos:

| go.mod                                        | Binario generado |
|-----------------------------------------------|------------------|
| module hello-world                            | ./hello-world    |
| module github.com/aicastell/calculadora       | ./calculadora    |
| module mi-servicio                            | ./mi-servicio    |

Esta convención refuerza la idea de que el ejecutable representa al módulo completo, no a un archivo concreto.

### Garantizar la unicidad global

Go evita colisiones de nombres fomentando el uso de dominios controlados por el autor:

```
module github.com/tu-usuario/tu-proyecto
```

Esto garantiza:

- Ausencia de ambigüedades.
- Resolución segura de dependencias.
- Un ecosistema descentralizado y escalable.

No hay un registro central obligatorio. La autoridad de un repositorio la tiene quien controla el dominio de ese repositorio.

## La versión de Go

Dentro del archivo `go.mod` aparece una línea aparentemente inofensiva, pero con un impacto profundo en cómo se interpreta y compila tu código:

```
go 1.24
```

Esta linea no indica la versión de Go que tienes instalada. Lo que indica es la versión del lenguaje para la que fue escrito el módulo.

Este valor actúa como un interruptor de compatibilidad que define:

- Qué sintaxis es válida.
- Qué reglas aplica el compilador.
- Cómo se resuelven dependencias.
- Qué comportamiento debe mantener la toolchain.

Aunque tengas Go 1.30 instalado, si tu módulo declara `go 1.24`, la herramienta `go` se comportará como si estuviera compilando con las reglas de Go 1.24. Esto evita roturas silenciosas y garantiza estabilidad a largo plazo. Sin esta restricción podrías tener cambios de comportamiento o generar bugs muy difíciles de encontrar.

Actualizar esta versión es una decisión que implica aceptar los nuevos comportamientos del lenguaje de forma consciente. Al hacerlo:

- Aceptas los nuevos comportamientos del lenguaje.
- Permites el uso de nuevas construcciones sintácticas.
- Asumes posibles cambios sutiles en el comportamiento del compilador.

Por eso, subir esta versión suele hacerse tras actualizar dependencias, adaptar tu código fuente y validar que todo sigue funcionando correctamente.

# Crear un módulo

En Go, crear un módulo es un paso explícito y obligatorio. No ocurre de forma automática ni implícita. Desde el directorio raíz del proyecto, ejecuta:

```
$ go mod init nombre-del-modulo
```

Este comando:

- Crea el archivo go.mod.
- Marca el directorio como raíz del módulo.
- Define la identidad canónica del módulo.
- Habilita la resolución de dependencias.
- Activa el sistema de builds reproducibles.

Desde ese momento, todo el código bajo ese directorio pertenece al módulo.

# El archivo go.sum

El archivo `go.sum` complementa a `go.mod`. Mientras `go.mod` declara qué dependencias necesitas, `go.sum` garantiza qué código exacto se ha descargado.

Contiene hashes criptográficos de cada módulo y versión utilizados, y permite que Go verifique que:

- El código no ha cambiado.
- No se ha introducido código malicioso.
- Las builds son idénticas hoy y mañana.

Este fichero `go.sum` tiene algunas características:

- No se edita a mano.
- Se genera y actualiza automáticamente.
- Forma parte del sistema de seguridad de Go.

Sin `go.sum`, Go no podría garantizar builds reproducibles ni integridad del código descargado.

# Comandos útiles relacionados con módulos

Algunos comandos básicos que conviene conocer desde el principio:

```
$ go mod init     # Inicializa un módulo
$ go mod tidy     # Limpia y sincroniza dependencias
$ go list -m all  # Lista todos los módulos usados
```

En la mayoría de proyectos pequeños, go mod tidy es suficiente para mantener todo en orden.

# Conclusión

Con los módulos, Go deja clara una idea fundamental: un proyecto debe ser identificable, reproducible y verificable sin ambigüedades. El módulo define el perímetro del proyecto, su identidad en el ecosistema, las reglas del lenguaje que aplica y las dependencias exactas de las que depende. Nada queda implícito, nada depende del entorno local.

Si has entendido qué es un módulo y qué papel juegan `go.mod` y `go.sum`, ya has asimilado una de las decisiones de diseño más importantes de Go. A partir de aquí, todas las herramientas del lenguaje (compilación, testing, despliegue) trabajan sobre esta base sólida.

Ahora que ya tienes claro lo que es un módulo en Go, toca ordenar el contenido del módulo. En el próximo artículo pasaré a explicar qué son los paquetes en Go: cómo se organizan, por qué son la verdadera unidad de encapsulación del lenguaje y cómo influyen directamente en la mantenibilidad y claridad del código.

Si el artículo te ha resultado útil, te ha dejado preguntas abiertas o simplemente quieres intercambiar impresiones con gente que disfruta entendiendo cómo funcionan las cosas por dentro, puedes unirte al [canal de Telegram](https://t.me/lateclaescape). Es un espacio abierto y totalmente gratuito donde comparto novedades, resuelvo dudas y charlo directamente con otros desarrolladores que, como tú, les gusta profundizar en Go y en el desarrollo de software en general.

¡Nos vemos en el próximo articulo!.

Pulso la tecla ESC, dos puntos wq!
