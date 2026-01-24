---
title: Bloques y ámbito en Go
date: 2026-01-21
image: /img/posts/golang-block-scope.webp
categories: [ "programming_language" ]
tags: [ "golang", "block", "scope", "flow_control" ]
draft: false
featured: true
---

# Introducción

Hasta ahora has aprendido a declarar valores y a agruparlos: variables, constantes y tipos primitivos. Todos esos elementos existen dentro de un programa que se ejecuta de forma secuencial. Sin embargo, el código real no es una lista plana de declaraciones: está organizado en unidades lógicas que establecen límites claros de visibilidad y alcance para cada identificador.

Para entender esos límites, necesitamos introducir dos conceptos fundamentales en Go: los **bloques** y el **scope** (ámbito).

Estos conceptos no son accesorios. Forman parte del modelo mental del lenguaje y condicionan cómo se escribe, se lee y se razona sobre un programa en Go.

Las estructuras de control combinan dos ideas fundamentales:

- una condición, que se evalúa como verdadera o falsa.
- un bloque de instrucciones, que se ejecuta únicamente cuando esa condición se cumple.

Este artículo se centra exclusivamente en el segundo elemento: los bloques de instrucciones. En el próximo articulo trataremos las condiciones.

Un bloque agrupa un conjunto de sentencias que se ejecutan como   una unidad y, al mismo tiempo, define el ámbito en el que existen y son visibles las variables declaradas en su interior.


# El bloque: la unidad semántica básica

En Go, las llaves `{}` no son un simple detalle sintáctico. Indican el inicio y el final de un **bloque de código**.

Un **bloque de código** es una región del programa que agrupa declaraciones e instrucciones y que define un límite preciso para la existencia y visibilidad de los nombres que se declaran en su interior.

Todo identificador (variables, constantes, tipos) declarado dentro de un bloque solo existe mientras se está ejecutando ese bloque y solo es visible dentro de él.

En Go, cada vez que ves un par de llaves `{}`, estás ante un bloque.

Algunos bloques los escribes de forma explícita, usando `{}` directamente. Otros los introduce el propio lenguaje como parte de determinadas construcciones (que veremos más adelante). En ambos casos, las reglas son exactamente las mismas: las llaves delimitan un bloque y, con él, un ámbito de visibilidad.

En este artículo nos centraremos únicamente en los bloques que puedes escribir explícitamente. Más adelante, cuando aparezcan nuevas construcciones del lenguaje, no habrá nada nuevo que aprender sobre bloques: solo los estarás usando en contextos distintos.

Ejemplo:

```
{
    var x int = 42
    const saludo = "hola"
    var edades [3]int = [3]int{20, 30, 40}

    fmt.Println(x)       // 42
    fmt.Println(saludo)  // hola
    fmt.Println(edades)  // [20 30 40]
}
// Aquí fuera, x, saludo y edades ya no existen
```

Todo lo que se declara dentro de un bloque solo es accesible dentro de ese bloque.

Dentro del bloque, `x`, `saludo` y `edades` existen y pueden usarse sin problema. Fuera del bloque, dejan de existir y no pueden referenciarse.

Esta regla no es arbitraria. Es una decisión deliberada del lenguaje que permite a Go:

- Limitar el alcance de los datos.
- Evitar dependencias innecesarias entre distintas partes del programa.
- Reducir errores provocados por el uso accidental de variables fuera de contexto.

# Qué es el scope

El scope (ámbito) de una variable o constante es la región exacta del código donde ese nombre es visible y se puede usar.

En Go, el scope está directamente ligado a los bloques `{}`.

- Una variable declarada dentro de un bloque pertenece a ese bloque.
- Una variable declarada fuera no es visible dentro, salvo que el bloque esté anidado.

Ejemplo:

```
var a int = 5

{
    var b int = 10
    fmt.Println(a) // válido
    fmt.Println(b) // válido
}

fmt.Println(a) // válido
fmt.Println(b) // error: b no está definida aquí
```

Aquí ocurre lo siguiente:

- `a` se declara fuera del bloque, por lo que es visible tanto fuera como dentro de él.
- `b` se declara dentro del bloque, por lo que solo existe dentro de ese bloque.

El scope define, de forma estricta y predecible, dónde un nombre puede ser utilizado.

# Jerarquía de scopes en Go

Go organiza la visibilidad de los nombres en distintos niveles de ámbito

## Scope de paquete

Todo lo declarado en el nivel superior de un archivo (fuera de cualquier bloque) pertenece al scope de paquete. Y es visible desde todos los ficheros fuente que forman parte de ese paquete.

Ejemplo:

```
package main

var Paquete int = 100          // visible en todo el paquete
const Limite = 1000            // ídem
```

Tanto la variable `Paquete` como la constante `Limite` son visibles desde cualquier archivo del paquete `main`.

## Scope de bloque

Cada bloque crea su propio “espacio privado” para variables y constantes. Una variable o una constante declarada dentro de un bloque `{}` solo existe dentro de ese bloque. Es el ámbito más común y el más restrictivo.

Los bloques pueden anidarse. En ese caso, se aplica una regla simple:

- Desde un bloque interno puedes usar lo que ya estaba declarado fuera.
- Desde un bloque externo no puedes usar lo que se declaró en un bloque interno.

```
{
    var x int = 1
    {
        var y int = 2
        fmt.Println(x)  // 1 (ve el externo)
        fmt.Println(y)  // 2
    }
    fmt.Println(x)      // 1
    // fmt.Println(y)   // ERROR
}
```

Dentro del bloque interno puedes usar `x` e `y`. Pero cuando sales al bloque externo, `y` desaparece, y solo puedes usar `x`. Esta forma de trabajar evita confusiones y hace que cada dato exista únicamente donde tiene sentido usarlo.

# Sombreado de variables (shadowing)

Go permite declarar una variable o constante con el mismo nombre que una existente en un bloque externo. En ese caso, la nueva oculta (shadows) a la anterior dentro de su bloque.

```
var x int = 10

{
    var x int = 20
    fmt.Println(x) // 20
}

fmt.Println(x) // 10
```

Aquí no hay reasignación. Hay dos variables distintas, con el mismo nombre, viviendo en scopes diferentes.

Este comportamiento es legal y, en algunos casos, útil. Go lo permite porque el scope es explícito y predecible. Aun así, el programador es responsable de no introducir ambigüedad innecesaria.

Mucho cuidado al hacer shadowing con el operador `:=`, porque es una fuente de bugs sutiles difíciles de detectar:

```
n := 5
{
    n := 10     // shadowing con :=
    fmt.Println(n)  // 10
}

fmt.Println(n)  // 5
```

El problema del shadowing con `:=` no es técnico, sino cognitivo: el código compila, y se ejecuta correctamente. Pero es fácil asumir que se está modificando una variable existente cuando, en realidad, se está creando una nueva en un scope distinto.

Por eso, el shadowing debe usarse con criterio y solo cuando mejora la claridad del código.

# Reglas importantes que debes conocer

No puedes declarar la misma variable dos veces en el mismo bloque

```
var x int = 1
var x int = 2  // ERROR: x redeclared in this block
```

Las constantes siguen las mismas reglas de visibilidad que las variables, aunque su valor se evalúe en tiempo de compilación.

Cuando una variable se declara sin inicializar dentro de un bloque, toma su **zero value** al entrar en él. Al salir del bloque, la variable deja de existir y ya no puede usarse.

Incluso las variables de paquete están limitadas al paquete al que pertenecen. Go no permite acceso global sin restricciones.

# Por qué Go es estricto con el scope

Go no permite usar variables fuera de su ámbito, ni siquiera si "sabemos" que existen. Esta decisión tiene consecuencias muy positivas:

- El código es más fácil de razonar.
- Los errores se detectan en tiempo de compilación.
- Se reduce el número de estados posibles del programa.

Nada vive más tiempo del necesario. Y nada es visible donde no deba serlo.

Esta filosofía encaja con todo lo que ya has visto en el lenguaje: tipos explícitos, zero values bien definidos y reglas claras desde el primer momento.

# Relación con lo que viene después

Relación con lo que viene después

A partir de aquí, los bloques `{}` se convertirán en una pieza central del lenguaje:

- Las estructuras de control se basan en bloques.
- Las funciones definen su propio scope.
- El tiempo de vida de las variables depende de dónde se declaran.

Antes de hablar de decisiones condicionales o de funciones, era imprescindible entender dónde existen las variables y durante cuánto tiempo.

El terreno ya está preparado.

# Resumen mental

- Un bloque `{}` define una unidad lógica y semántica.
- Las variables declaradas dentro de un bloque solo existen en ese bloque.
- El scope determina dónde una variable o una constante es visible.
- Los bloques pueden anidarse y heredan visibilidad hacia dentro.
- Go permite sombreado de variables, pero de forma explícita.
- El control del scope es clave para escribir código claro y seguro.

# Cierre

Antes de decidir qué código se ejecuta, Go te obliga a tener claro dónde vive cada dato. Los bloques y el scope no son un detalle sintáctico: forman parte esencial del modelo mental del lenguaje.

Con esta base, ya estamos listos para dar el siguiente paso: introducir estructuras que permitan tomar decisiones y ejecutar distintos bloques de código según el estado del programa.

Eso es exactamente lo que veremos en el próximo articulo.

Si este artículo te ha resultado útil, si te ha surgido alguna duda o simplemente te apetece comentar lo que estás aprendiendo, te invito a unirte al [canal de Telegram](https://t.me/lateclaescape). Es un espacio abierto y gratuito donde compartimos conocimiento, resolvemos dudas y hablamos sobre desarrollo de software, ideas y proyectos reales, siempre con ganas de aprender y mejorar juntos.

¡Nos vemos en el próximo articulo!

Pulso la tecla `ESC:wq!`
