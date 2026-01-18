---
title: Variables tipadas en Go
date: 2026-01-18
image: /img/posts/golang-typed-variables.webp
categories: [ "programming_language" ]
tags: [ "golang", "variables" ]
draft: false
featured: true
---

# Introducción

En artículos anteriores exploramos qué son las [variables en Go](/post/2026/golang-variables) y cuáles son los [tipos de datos primitivos](/post/2026/golang-data-types) que ofrece este lenguaje.

Ha llegado el momento de unir ambos conceptos. En este artículo veremos cómo Go vincula variables y tipos, por qué toda variable tiene siempre un tipo, y cómo elegir entre dejar que el compilador infiera ese tipo o especificarlo tú mismo. Esta decisión no es solo técnica: afecta a la claridad, la intención y la mantenibilidad del código.

# El tipo siempre existe

En Go no existen variables sin tipo. Cuando escribes:

```
x := 10
```

no estás creando una variable "genérica" o "dinámica". Estás usando la inferencia de tipos, un mecanismo en tiempo de compilación mediante el cual Go deduce el tipo de una variable a partir del valor de inicialización. En este caso, el compilador asigna el tipo `int` a la variable `x`, y ese tipo queda fijado para toda la vida de la variable.

Estas dos declaraciones de variable son equivalentes en Go:

```
var x int = 10
x := 10
```

La diferencia no radica en el resultado, sino en **quién** aporta la información del tipo:

- explicito: tú aportas el tipo
- implícito: el tipo lo aporta el compilador

## Declaración explícita del tipo

La forma más directa de asociar un tipo a una variable es declararlo explícitamente:

```
var edad int = 30
```

Aquí defines tres propiedades de forma explicita:

- el nombre de la variable (`edad`)
- el tipo exacto que tendrá (`int`)
- el valor inicial (`30`)

Esta forma brilla en situaciones donde la inferencia podría ser ambigua o insuficiente para expresar intención. Por ejemplo:

```
var timeout int64 = 30
```

Aunque el literal `30` encajaría en un `int`, al escribir `int64` comunicas que este valor representa algo con requisitos específicos de rango o alineación (por ejemplo, un tiempo en nanosegundos, un ID distribuido, etc.). No es solo almacenamiento: es semántica.

También puedes declarar una variable indicando solo el tipo, sin asignar un valor explícito:

```
var contador int
```

Go inicializa automáticamente la variable con el valor cero correspondiente a su tipo (0 para enteros, "" para cadenas, false para booleanos, etc.). Esto garantiza que la variable siempre tenga un estado válido desde el momento de su creación.

Este patrón es útil cuando necesitas que la variable exista antes de que se le asigne un valor significativo.

## Declaración implícita del tipo

En la mayoría del código cotidiano, no es necesario escribir el tipo explícitamente. La inferencia suele ser más que suficiente y mejora la legibilidad:

```
nombre := "Go"
activo := true
pi := 3.14159
```

Nadie duda de que `nombre` es una cadena, `activo` un booleano o `pi` un número en coma flotante. Go está diseñado para que la inferencia sea segura, estática y predecible: ocurre en compilación, no en ejecución, y no implica magia ni conversiones implícitas.

Una buena regla práctica es que, si el tipo se deduce fácilmente leyendo el valor, no lo escribas de nuevo.

Es crucial entender que inferir no es postergar. El tipo no se decide "más tarde" ni depende del contexto de uso. Se determina una sola vez, en el momento de la declaración, y se fija de forma definitiva para todo el tiempo de vida de la variable.

# El tipo es inmutable

Una vez que una variable ha sido declarada, bien por inferencia o de forma explícita, su tipo nunca cambia. Esta inmutabilidad es una piedra angular de la seguridad de Go.

Considera este ejemplo:

```
x := 10
x = 20      // correcto
x = 3.14    // ERROR
```

Aunque 3.14 es un número, su tipo (`float64`) no coincide con el de x (`int`). Go no realiza conversiones implícitas, ni siquiera entre tipos numéricos aparentemente compatibles.

Esta rigidez no es una limitación: es una decisión de diseño que permite:

- detectar errores en tiempo de compilación
- evitar pérdidas de precisión o desbordamientos inadvertidos
- generar código más eficiente
- razonar con certeza sobre el estado del programa

# Cuándo conviene ser explícito con el tipo

Aunque la inferencia es muy poderosa, hay casos donde la declaración explícita del tipo mejora significativamente el código:

- Variables a nivel de paquete (especialmente variables públicas)
- Valores con semántica específica: IDs, tiempos, tamaños, contadores
- APIs públicas o interfaces de librerías
- Inicializaciones con valor cero donde la intención debe quedar clara

Ejemplo:

```
var userID int64 // sugiere escalabilidad
var maxRetries uint // comunica que no puede ser negativo
```

En estos casos, el tipo no describe solo cómo se almacena el dato, sino qué representa. Es documentación ejecutable.

# Resumen mental

- Toda variable en Go tiene un tipo, **siempre**.
- El tipo se fija en la declaración y no cambia nunca.
- Puedes especificarlo explícitamente o dejar que el compilador lo infiera.
- La inferencia es segura, estática y no sacrifica rendimiento ni claridad.
- Ser explícito no es una obligación técnica, sino una herramienta de diseño.
- Elige la forma que mejor comunique tu intención.

# Conclusión

Go no te obliga a elegir entre "tipado explícito" o "tipado implícito". Te da ambas herramientas, y espera que las uses con criterio. El código idiomático en Go no es el que más tipos escribe, ni el que menos: es el que usa el tipo justo en el momento justo para hacer la intención evidente.

Saber cuándo confiar en la inferencia y cuándo imponer un tipo explícito es una de las marcas del programador Go que no solo escribe código que funciona, sino código que comunica.

En el próximo artículo daremos un paso más allá y exploraremos las constantes tipadas, en contraste con las no tipadas. Veremos por qué Go permite comportamientos con constantes que serían impensables con variables, y cómo esta flexibilidad controlada enriquece el sistema de tipos sin comprometer su seguridad.

¿Has aprendido algo leyendo este artículo? Únete al [canal de Telegram](https://t.me/lateclaescape) del blog, y pregúntame cualquier duda que te quede pendiente. Allí respondo personalmente a cada pregunta planteada.

Muchas gracias por leerme y, ¡nos vemos en el próximo artículo!.

Pulso la tecla `ESC:wq!`
