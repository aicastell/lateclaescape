---
title: Constantes tipadas en Go
date: 2026-01-19
image: /img/posts/golang-typed-const.webp
categories: [ "programming_language" ]
tags: [ "golang", "const" ]
draft: false
featured: true
---

# Introducción

En un artículo anterior conocimos las [constantes en Go](/post/2026/golang-const) y vimos cómo representan valores fijos evaluados en tiempo de compilación.

De forma intencionada, en ese articulo no entré en el papel que juegan los [tipos de datos](/post/2026/golang-data-types). Esa omisión no fue accidental: Go permite que algunas constantes no tengan un tipo asociado desde el momento en que se declaran.

La pregunta natural es, ¿qué ocurre cuando queremos que una constante sí tenga un tipo fijo desde su declaración? ¿Cómo y cuándo entra el sistema de tipos en juego?.

En este artículo vas a entender qué significa que una constante sea tipada o no tipada, en qué situaciones se aplica cada una, y cómo esta distinción influye directamente en la claridad, la seguridad y el diseño del código en Go.

# El punto de partida: constantes sin tipo

Aquí declaro algunas constantes sin hacer mención explicita a su tipo:

```
const x = 10          // sin tipo
const pi = 3.14159    // sin tipo
const saludo = "hola" // sin tipo
```

Esta ausencia de tipo otorga una flexibilidad muy poderosa: el mismo valor puede usarse en muchos contextos diferentes sin necesidad de conversiones explícitas.

Por ejemplo, cuando declaras `x`, ésta no tiene todavía un tipo concreto. No es `int`, ni `int64`, ni `float64`. Es simplemente el valor literal `10`, conocido por el compilador en tiempo de compilación, y disponible para ser usado en distintos contextos. Esto permite hacer algo muy potente:

```
var a int     = x     // se comporta como int
var b int64   = x     // se comporta como int64
var c float64 = x     // se comporta como float64
var d uint8   = x     // se comporta como uint8 (porque 10 cabe)
```

Fíjate en lo que ocurre: el mismo valor de `x` puede adaptarse a distintos tipos sin conversiones explícitas, siempre que el valor sea representable en este tipo.

Todo esto ocurre en tiempo de compilación. El compilador verifica que el valor sea representable en el tipo destino.

Este comportamiento es exclusivo de las constantes. Las variables no funcionan así, como ya vimos en el articulo sobre [variables en Go](/post/2026/golang-variables).

# Constantes tipadas

Una constante se convierte en **constante tipada** cuando su tipo de dato queda fijado. Esto puede ocurrir de dos formas:

## Tipado explícito

Puedes indicar el tipo directamente en la declaración:

```
const MaxRetries int      = 5
const Timeout    int64    = 30
const Pi         float64  = 3.141592653589793
```

Desde el instante que se declara, la constante es de ese tipo y punto. No hay vuelta atrás.

Ejemplo:

```
var a int   = MaxRetries   // correcto
var b int64 = MaxRetries   // cannot use x (constant 5 of type int) as int64 value in variable declaration

```

El compilador ya no puede adaptar el valor a otro tipo, porque el tipo ha quedado fijado desde la misma declaración de la constante.

## Tipado por contexto

Una constante no tipada adquiere un tipo solo en el momento en que se usa, y ese tipo depende del contexto en el que aparece.

Ejemplo:

```
const x = 10

var a int = x
var b int64 = x
```

Aquí ocurre algo importante:

- `x` es una constante sin tipo
- al asignar `x` a la variable `a`, el compilador la interpreta como `int`
- al asignar `x` a la variable `b`, el compilador la interpreta como `int64`
- `x` no deja de ser una constante sin tipo, pero se interpreta como un `int` o como `int64` dependiendo del contexto

Este matiz es sutil, pero fundamental para entender uno de los conceptos mas elegantes -y a menudo mal entendidos- del sistema de tipos de Go.

# Constantes tipadas vs no tipadas

La diferencia entre constantes tipadas y no tipadas no está en el valor de inicialización, sino en la flexibilidad del tipo.

Veamos esta tabla comparativa:

| Característica | Constante sin tipo | Constante tipada |
|----------------|--------------------|------------------|
| ¿Tiene tipo fijo? | No | Sí, desde la declaración |
| ¿Se adapta al contexto? | Sí, a cualquier tipo compatible | No, solo su tipo declarado |
| Flexibilidad | Muy alta | Baja |
| ¿Cuándo adquiere tipo? | Cuando el contexto lo exige (en compilación) | En la propia declaración |

# Por qué Go permite constantes sin tipo

Las constantes sin tipo son una herramienta del diseño de Go muy meditada. Tienen varios usos:

Permiten expresar valores universales de forma natural:

```
const Zero = 0
const One = 1
const Pi = 3.14159
```

Evitan conversiones explícitas por todas partes:

```
time.Sleep(500 * time.Millisecond) // 500 es sin tipo, se adapta sin problemas
```

Y finalmente, mantienen total seguridad en tiempo de compilación:

```
const Enorme = 1e100
var x int64 = Enorme     // cannot use Enorme (untyped float constant 1e+100) as int64 value in variable declaration (truncated)
```

El compilador te protege antes de que el programa siquiera exista.

Lejos de debilitar el sistema de tipos estático, las constantes sin tipo lo refuerzan: dan flexibilidad donde es segura (en compilación) y obligan a ser explícito donde la semántica importa.

# Cuando usar constantes tipadas

Las constantes tipadas deben usarse cuando el tipo forma parte del significado o quieres comunicar intención:

```
const (
    MaxWorkers     int     = 100      // límite razonable de workers
    DefaultTimeout int64   = 30       // segundos, no milisegundos
    BufferSize     uint32  = 65536    // bytes, tamaño de buffer de red
    Version        string = "v2.3.1"  // tipo string explícito por claridad
)
```

En estos casos el tipo documenta la constante y reduce el riesgo de usarla en un contexto equivocado.

# Conclusión

Las constantes sin tipo y las constantes tipadas no son un detalle técnico oscuro: son una de las decisiones más elegantes del diseño de Go.

Combinan la flexibilidad casi dinámica para valores genéricos y matemáticos (sin sacrificar seguridad), y la rigurosidad estática cuando la claridad semántica y el control de tipos importan.

Entender bien esta dualidad es un paso importante para escribir código Go idiomático, limpio y que comunica intención con fuerza.

¿Has aprendido algo leyendo este artículo? Únete al [canal de Telegram](https://t.me/lateclaescape) del blog, y pregúntame cualquier duda que te quede pendiente. Allí respondo personalmente a cada pregunta planteada.

¡Nos vemos en el próximo artículo!

Pulso la tecla `ESC:wq!`
