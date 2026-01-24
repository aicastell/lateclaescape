---
title: Condiciones en Go
date: 2026-01-24
image: /img/posts/golang-flow-control-conditions.jpg
categories: [ "programming_language" ]
tags: [ "golang", "variables" ]
draft: false
featured: true
---

# Introducción

En el artículo anterior vimos cómo Go organiza el código mediante [bloques de instrucciones](/post/2026/golang-block-scope).

Sin embargo, los bloques de instrucciones no se ejecutan de forma arbitraria. En un programa real, la ejecución del código depende de decisiones que se toman durante su ejecución y que determinan cuándo un bloque debe ejecutarse y cuándo debe omitirse. Estas decisiones constituyen la base del control de flujo.

Todas las estructuras de control de flujo se apoyan en una idea fundamental: una condición que se evalúa como verdadera o falsa y que determina si el bloque de instrucciones asociado se ejecuta o no. Este artículo se centra exclusivamente en las condiciones en Go.

# El tipo bool

Go dispone de un tipo primitivo específico para representar valores lógicos: `bool`. Este tipo solo permite dos valores:

- verdadero, `true`
- falso, `false`

No hay valores intermedios, ni equivalencias implícitas. Este diseño es deliberado y marca una diferencia clara con otros lenguajes como C o C++.

# Qué es una condición

En Go, una condición es una expresión que se evalúa como verdadera o falsa. Es decir, cualquier expresión cuyo resultado sea de tipo `bool`.

# Operadores de comparación

La forma más común de construir una condición es mediante **operadores de comparación**.

| Operador | Significado |
|----------|-------------|
| == | Igual |
| != | Distinto |
| < | Menor que |
| <= | Menor o igual que |
| > | Mayor que |
| >= | Mayor o igual que |

Todas estas expresiones devuelven un `bool` como resultado de su evaluación:

```
x := 10

x > 5          // true
x == 10        // true
x != 0         // true

s := "go"

s == "Golang"  // false
s != ""        // true
```

Por tanto, pueden usarse como condiciones.

# Condiciones estrictamente booleanas

En algunos lenguajes como C o C++, las expresiones escalares pueden evaluarse directamente en un contexto condicional: el valor 0 se considera falso y cualquier valor distinto de 0 se considera verdadero. Este comportamiento permite utilizar expresiones numéricas como condiciones sin necesidad de una comparación explícita.

Go adopta un enfoque diferente. En Go, una condición debe ser siempre una expresión de tipo `bool`. No existen conversiones implícitas ni interpretaciones automáticas de otros tipos como valores lógicos. Esto significa que:

- Un entero distinto de cero no es verdadero
- Un string no vacío no es verdadero
- Un valor existente no es verdadero

Dadas las siguientes variables:

```
x := 10
s := "hola"
```

Las siguientes expresiones **NO** son condiciones válidas en Go, ya que no producen un valor booleano:

```
x
s
len(s)
```

Esta decisión de diseño obliga a expresar las condiciones de forma explícita, elimina ambigüedades y reduce la aparición de errores sutiles en el control de flujo.

# Operadores lógicos

Go permite combinar condiciones mediante operadores lógicos, que también producen valores `bool`.

# AND lógico (&&)

La expresión es verdadera solo si ambas condiciones son verdaderas.

```
x > 0 && x < 10
```

# OR lógico (||)

La expresión es verdadera si al menos una condición es verdadera.

```
x < 0 || x > 100
```

# NOT lógico (!)

Invierte el valor de una condición.

Ejemplo:

```
!true // false
!false // true
```

El resultado de esta condición es `true`.

# Precedencia y paréntesis

Los operadores en Go tienen un orden de evaluación bien definido. Sin embargo, confiar en que el lector conozca ese orden no siempre es la mejor opción.

Considera la siguiente expresión:

```
x > 0 && x < 10
```

Aunque la expresión es correcta, su comprensión requiere conocer la precedencia de los operadores relacionales y lógicos. Para quien lee el código, la intención no es inmediata.

Añadiendo paréntesis, el desarrollador deja clara su intención:

```
(x > 0) && (x < 10)
```

El uso de paréntesis no cambia el resultado de la expresión, pero sí mejora de forma notable su legibilidad. En Go, esta claridad es preferible a la concisión, ya que reduce errores y facilita el mantenimiento del código a largo plazo.

# Relación entre condiciones y bloques

Una condición, por sí sola, no ejecuta ningún código. Su única función es responder a una pregunta concreta: ¿se cumple o no se cumple? El resultado de esa evaluación es siempre un valor booleano.

La ejecución del código depende del bloque de instrucciones al que la condición esté asociada. El bloque contiene el conjunto de sentencias que se ejecutarán únicamente si la condición se evalúa como verdadera. Sin un bloque asociado, una condición no tiene ningún efecto sobre el flujo del programa.

Esta separación de responsabilidades es fundamental en Go y conecta directamente con lo visto en el artículo anterior. El bloque define qué código forma parte de una decisión. Y la condición define cuándo debe ejecutarse ese código.

Ambos conceptos son independientes, pero solo cobran sentido cuando se combinan. Esta combinación es la base del control de flujo explícito en Go, donde las decisiones y el código que depende de ellas están claramente separados.

# Resumen mental

- Las condiciones en Go siempre devuelven `bool`.
- Solo `true` y `false` son válidos.
- Las comparaciones son explícitas.
- Los operadores lógicos combinan condiciones.
- Las condiciones no ejecutan código, solo deciden.

# Conclusión

Las condiciones son el lenguaje con el que un programa expresa sus decisiones. Por sí solas no ejecutan código, pero determinan cuándo debe hacerlo.

Una vez comprendidos los bloques de instrucciones y las condiciones, las estructuras de control dejan de ser un conjunto de reglas sintácticas y pasan a convertirse en una consecuencia natural del modelo del lenguaje. En el próximo artículo daremos ese paso y veremos la estructura de control `if`, que permite asociar condiciones a bloques de instrucciones de forma explícita y predecible.

Si te has quedado con dudas o quieres profundizar en algún punto, puedes unirte al [canal de Telegram](https://t.me/lateclaescape). Es totalmente gratuito y un buen espacio para resolver preguntas y mejorar conjuntamente el contenido de los artículos.

Gracias por leerme y, como siempre, nos vemos en el próximo artículo.

Pulso la tecla `ESC:wq!`
