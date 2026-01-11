---
title: Paquetes en Go
date: 2026-01-07
image: /img/posts/golang-packages.webp
categories: [ "programming_language" ]
tags: [ "golang", "packages" ]
draft: false
featured: true
---

# Introducción

En el artículo anterior expliqué los [módulos en Go](/post/2026/golang-modules). Los módulos definen *qué es un proyecto*: el perímetro, su identidad global y la base sobre la que se construyen las dependencias y la reproducibilidad.

Sin embargo, un módulo por sí solo no organiza el código internamente ni establece límites entre unas partes y otras. Un módulo puede crecer sin control, con cientos o miles de archivos compartiendo el mismo espacio conceptual. Para resolver este problema, Go introduce su siguiente concepto fundamental: `los paquetes`.

Este artículo explica qué es un paquete en Go, qué reglas impone el lenguaje, cómo se estructuran los proyectos y por qué la simplicidad del sistema de paquetes es una de las claves de la claridad y mantenibilidad del código Go.

# Paquetes en Go

Un `paquete` es la unidad básica de organización y encapsulación del código en Go. Un paquete agrupa código que:

- Está relacionado conceptualmente.
- Comparte un mismo espacio de nombres.
- Se compila como una unidad.
- Define qué símbolos expone y cuáles mantiene internos

En Go los paquetes no son opcionales:

- Todo archivo .go pertenece obligatoriamente a un paquete.
- Un archivo .go no puede pertenecer a más de un paquete.
- No existe código "suelto" que no pertenezca a ningún paquete.

Para entenderlo sin rodeos: en Go, un módulo representa un proyecto completo. Define su identidad, su versión y sus dependencias. Un módulo está compuesto por uno o varios paquetes. Los paquetes son las piezas en las que se organiza el código fuente. Y cada paquete cumple una responsabilidad concreta dentro del proyecto. Los paquetes viven siempre dentro de un módulo.

Ejemplo típico de estructura:

```
mi-proyecto/
├── go.mod
├── main.go
├── config/
│   └── config.go
├── server/
│   └── server.go
└── storage/
    └── storage.go
```

Aquí tenemos:

- Un módulo (mi-proyecto, definido en go.mod)
- Varios paquetes: main, config, server, storage

# Un directorio, un paquete

Go impone una regla simple pero muy estricta:

> Cada directorio del proyecto define exactamente un paquete

Esto tiene varias consecuencias importantes:

- Todos los archivos .go dentro de un mismo directorio deben declarar el mismo `package`.
- No puedes mezclar varios paquetes en un mismo directorio.
- La estructura de carpetas refleja directamente la estructura lógica del código.

Ejemplo:

```
// archivo: server/server.go
package server
...
```

```
// archivo: server/router.go
package server
...
```

Ambos archivos pertenecen al mismo paquete server y Go los compila como una sola unidad lógica.

# Declaración del paquete

En Go, todo archivo fuente debe comenzar con una declaración `package`:

```
package nombre_del_paquete
```

Esta línea determina a qué paquete pertenece el fichero fuente. En este ejemplo:

```
$ cat main.go
package main

import "fmt"

func main() {
    fmt.Println("Hola mundo")
}
```

el fichero fuente `main.go` pertenece al paquete `main`.

Esta línea es obligatoria para que el código compile. Si no defines `package`:

```
$ cat main.go
import "fmt"

func main() {
    fmt.Println("Hola mundo")
}
```

se genera un error de compilación:

```
$ go run main.go
main.go:3:1: expected 'package', found 'import'
```

El nombre del paquete no tiene por qué coincidir con el nombre del directorio, pero hacerlo es una convención fuertemente recomendada. No seguirla genera confusión innecesaria.

# Tipos de paquetes en Go

En Go existen dos grandes categorías de paquetes:

- El paquete main
- Los paquetes de librería

## El paquete main

El paquete main es especial. Indica que el código es un programa ejecutable.

Un programa ejecutable en Go debe cumplir dos condiciones:

- Contener un paquete llamado `main`
- Definir una función `main()`

Ejemplo:

```
package main

import "fmt"

func main() {
    fmt.Println("Hola, mundo")
}
```

Características importantes:

- Solo puede existir un paquete `main` por binario ejecutable
- El paquete `main` no está pensado para ser reutilizado
- Es el punto de entrada del programa (entry point).
- La función main() no recibe parámetros ni devuelve valores.

## Paquetes de librería

Todo lo que no sea un binario ejecutable es un paquete de librería. Los paquetes de librería:

- No se ejecutan por sí solos.
- Encapsulan funcionalidad reutilizable.
- Están pensados para ser usados desde otros paquetes

Ejemplo:

```
package mathutils

func Sum(a, b int) int {
    return a + b
}
```

# Normas de nomenclatura

Algunas normas que se siguen habitualmente:

- Usa nombres cortos, claros y en singular: json, http, server
- Evita nombres genéricos: utils, common, helpers

# Paquetes con múltiples archivos

Un paquete puede contener tantos archivos como sea necesario:

```
mathutils/
├── add.go
├── multiply.go
└── helpers.go
```

Todos los ficheros de este paquete declaran:

```
package mathutils
```

Los símbolos no exportados son visibles entre todos los archivos del paquete, lo que permite dividir código en varios ficheros fuente sin perder encapsulación.

# Paquetes de la librería estándar

Go incluye una biblioteca estándar muy rica y bien diseñada:

| Librería                                           | Uso                                                                |
|----------------------------------------------------|--------------------------------------------------------------------|
| [fmt](https://pkg.go.dev/fmt)                      | formateo de texto y operaciones de entrada/salida básicas          |
| [net/http](https://pkg.go.dev/net/http)            | servidores y clientes HTTP completos                               |
| [encoding/json](https://pkg.go.dev/encoding/json)  | codificación y decodificación JSON                                 |
| [os](https://pkg.go.dev/os)                        | interacción con el sistema operativo (archivos, procesos, entorno) |
| [io](https://pkg.go.dev/io)                        | abstracciones e interfaces fundamentales de entrada/salida         |
| [time](https://pkg.go.dev/time)                    | manejo de tiempo, duraciones y temporizadores                      |
| [sync](https://pkg.go.dev/sync)                    | primitivas de sincronización para concurrencia segura              |

Con la librería estándar podrías hacer prácticamente cualquier proyecto sin usar librerías externas. Aquí puedes encontrar la [documentación oficial de la librería estándar](https://pkg.go.dev/std). Si quieres aprender Go en serio, explorarla es una obligación.

Puedes usar la herramienta `go doc` para revisar la documentación oficial desde la línea de comandos:

```
$ go doc fmt
```

# Conclusión

Si los módulos definen el perímetro del proyecto, los paquetes definen su arquitectura interna.

Go apuesta por reglas simples y explícitas: un directorio es un paquete, no hay magia y no hay ambigüedad. Entender bien los paquetes es esencial para escribir código Go claro, mantenible y idiomático.

El módulo ya está definido, el código ya está organizado. Ahora toca entender cómo colaboran estas piezas entre sí: cómo se comunican los paquetes, cómo se diseñan APIs internas y cómo evitar acoplamientos innecesarios.

¿Has aprendido algo leyendo este artículo? Únete al [canal de Telegram](https://t.me/lateclaescape) del blog, y cuéntame qué tema te gustaría que abordara a continuación. Allí respondo personalmente a cada pregunta planteada. Muchas gracias por leerme y nos vemos en el próximo artículo!

Pulso la tecla ESC, dos puntos wq!
