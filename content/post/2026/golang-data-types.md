---
title: Tipos de datos en Go
date: 2026-01-17
image: /img/posts/golang-datatypes.webp
categories: [ "programming_language" ]
tags: [ "golang", "packages" ]
draft: false
featured: true
---

# Introducción

En los artículos anteriores has aprendido qué son [las variables](/post/2026/golang-variables) y [las constantes](/post/2026/golang-const) en Go, y cómo se declaran. Con eso ya eres capaz de dar nombre a valores y trabajar con ellos.

El siguiente paso natural es entender qué tipo de datos pueden tomar esos identificadores.

En este artículo nos centraremos exclusivamente en los tipos primitivos de Go. Los tipos compuestos y más avanzados se tratarán en artículos posteriores.

# Variables y tipos de datos

Como vimos en el artículo sobre [variables en Go](/post/2026/golang-variables), el tipo de dato es una de las cuatro propiedades fundamentales de toda variable. En Go, toda variable tiene un tipo, y ese tipo determina:

- Qué valores puede almacenar
- Cuánta memoria ocupa
- Qué operaciones son válidas sobre ella

Dos ideas clave que conviene fijar desde el principio:

- El tipo de una variable se conoce en tiempo de compilación
- El tipo de una variable no cambia nunca

El sistema de tipos de Go es una de las claves de su diseño: es simple, explícito y seguro. No hay ambigüedades ni conversiones implícitas peligrosas; el compilador sabe en todo momento con qué está trabajando.

# Tipos primitivos en Go

| Categoría | Tipos comunes | Uso típico |
|-----------|---------------|------------|
| Booleanos | bool |  Lógica condicional |
| Enteros | int, int8, int16, int32, int64, etc. | Contadores, índices, flags |
| Enteros sin signo | uint, uint8, uint16, uint32, uint64, etc. | Contadores, índices, flags |
| Punto flotante | float32, float64 | Cálculos científicos o financieros |
| Complejos | complex64, complex128 | Números complejos |
| Texto | string | Texto UTF-8 inmutable |
| Alias numéricos | byte, rune | Datos binarios, I/O, etc. |

Vamos a verlos uno por uno.

## Booleanos

El tipo bool solo puede tomar dos valores:

- true
- false

Se utiliza para representar estados lógicos y resultados de comparaciones.

```
var activo bool = true
var terminado bool = false
```

## Cadenas de texto

El tipo string representa una secuencia de caracteres Unicode codificados en UTF-8.

Características importantes:

- Son inmutables
- Se definen con comillas dobles
- No son arrays de caracteres

```
var nombre string = "Go"
```

No puedes modificar un carácter individual dentro de un `string`. Cualquier "modificación" implica crear una nueva cadena.

## Números enteros

### Enteros con signo

| Tipo | Tamaño |
|------|--------|
| int | Depende de la arquitectura (32 o 64 bits) |
| int8 | 8 bits |
| int16 | 16 bits |
| int32 | 32 bits |
| int64 | 64 bits |

`int` es el tipo más usado para contadores, índices y lógica general.

### Enteros sin signo

| Tipo | Tamaño |
|------|--------|
| uint | Igual que int |
| uint8 | 8 bits |
| uint16 | 16 bits |
| uint32 | 32 bits |
| uint64 | 64 bits |

Los tipos `uint` se reservan para casos muy concretos donde el dominio del problema no admite valores negativos (por ejemplo, la edad).

## Alias especiales: byte y rune

Go define dos alias semánticos muy usados:

- byte: alias de uint8, usado para datos binarios y E/S.
- rune: alias de int32, usado para representar caracteres Unicode

Estos alias no crean tipos nuevos, solo mejoran la legibilidad del código.

## Números en coma flotante

Go tiene dos tipos de punto flotante:

- float32
- float64

`float64` es el tipo por defecto y el más usado.

```
var x float64 = 3.14159
```

Se utilizan para cálculos decimales, científicos o financieros (con las precauciones habituales de precisión).

## Números complejos

Go incluye soporte nativo para números complejos:

- complex64: partes real e imaginaria `float32`
- complex128: partes real e imaginaria `float64`

```
var z complex128 = 2 + 3i
```

Es una característica poco común en lenguajes de propósito general y muy útil en ciertos dominios.

# El concepto de zero value

Una de las ideas más importantes del diseño de Go es que toda variable tiene un valor válido desde el primer momento. Ese valor se llama **zero value**.

La siguiente tabla muestra los zero values de los distintos tipos primitivos:


| Tipo | Zero value |
|------|------------|
| bool | false |
| Enteros | 0 |
| Flotantes | 0.0 |
| Complejos | 0+0i |
| string | "" |

Ejemplos:

```
var edad int // 0
var nombre string // ""
var activo bool // false
```

Esto implica:

- No existe memoria sin inicializar
- No hay comportamiento indefinido
- No necesitas constructores solo para “rellenar” valores

Es una de las razones por las que el código en Go es más robusto por defecto.

# Go es un lenguaje fuertemente tipado

En Go:

- No existen variables "sin tipo"
- No hay conversiones implícitas entre tipos distintos
- No hay coerciones automáticas

Veamos un ejemplo:

```
var a int = 10
var b int64 = 10

// a = b // ERROR: tipos distintos
```

Aunque ambos valores sean numéricamente iguales, `int` e `int64` no son el mismo tipo.

Esto puede parecer estricto, pero evita errores silenciosos de precisión y comportamiento inesperado.

Si realmente quieres asignar uno a otro, debes hacerlo de forma explícita, dejando clara tu intención al compilador:

```
a = int(b)
```

Esto garantiza:

- Seguridad
- Rendimiento
- Código claro y predecible

El compilador actúa como una primera línea de defensa frente a errores.

Esta regla se aplica a todos los tipos en Go, no solo a los enteros.

# Resumen mental

- Toda variable en Go tiene un tipo
- El tipo se conoce en compilación y no cambia nunca
- Go no permite conversiones implícitas
- Los tipos primitivos cubren la mayoría de necesidades básicas
- Los zero values garantizan seguridad desde el primer momento

# Conclusión

El sistema de tipos de Go es deliberadamente sencillo, pero no simplista. Obliga a ser explícito, evita errores sutiles y comunica intención con claridad.

Con las bases de variables, constantes y tipos primitivos ya establecidas, estamos en condiciones de profundizar en cómo Go combina estos elementos para construir código robusto y predecible.

En los próximos artículos daremos dos pasos clave: primero veremos cómo funcionan las variables tipadas y qué implicaciones tiene fijar un tipo desde la declaración, y después entraremos en detalle en las constantes tipadas, donde el sistema de tipos de Go muestra una de sus decisiones de diseño más interesantes.

¿Te ha servido este contenido? Únete al [canal de Telegram]((https://t.me/lateclaescape)) de La Tecla Escape y dime qué tema te gustaría que abordara en los próximos artículos. Respondo personalmente a cada pregunta. Muchas gracias por leerme y nos vemos en el próximo artículo.

Pulso la tecla `ESC:wq!`
