---
title: Condiciones en Go
date: 2026-01-22
image: /img/posts/golang-flow-control-if-else.jpg
categories: [ "programming_language" ]
tags: [ "golang", "variables" ]
draft: true
featured: true
---

# Introducción

En articulos publicados anteriormente has aprendido los tipos primitivos de Go, cómo Go estructura el código mediante [bloques de instrucciones](/post/2026/golang-block-scope) y cómo se expresan en Go las [condiciones](/post/2026/golang-flow-control-conditions).

Sin embargo, un programa real no se limita a almacenar valores y ejecutar instrucciones en secuencia. Su verdadera utilidad reside en tomar decisiones: ejecutar ciertas partes del código y omitir otras según condiciones concretas.

En Go, estas decisiones se expresan combinando dos conceptos que ya conoces:

- **Condiciones**, que determinan si algo es verdadero o falso.
- **Bloques de instrucciones**, que se ejecutan como una unidad completa.

La sentencia `if` es la forma más directa y frecuente de unir ambos conceptos. Permite decidir cuándo se ejecuta un bloque de código y qué camino seguirá el programa según se cumpla o no una condición. En este artículo aprenderás a usar `if` y `else` para asociar condiciones a bloques de instrucciones de manera clara, explícita y predecible, sentando las bases para manejar el flujo de ejecución de tus programas en Go.

# Recordatorio: bloques y decisiones

Antes de entrar en la sintaxis de `if`, voy a reforzar una idea clave: Go no decide ejecutar instrucciones sueltas, decide ejecutar bloques completos.

Recuerda que un bloque de instrucciones es un conjunto de sentencias delimitado por llaves `{}`. Por ejemplo:

```
{
    instrucción 1
    instrucción 2
}
```

Cuando usamos `if`, asociamos un bloque a una condición:

- Si la condición es verdadera → se ejecuta el bloque completo, instrucción tras instrucción, en secuencia.
- Si es falsa → el bloque se omite por completo

Esta relación entre condición y bloque es la base de todo el control de flujo en Go.

# Sintaxis del if

La sintaxis mínima de un `if` en Go es esta:

```
if condicion {
    // bloque de instrucciones
}
```

Ejemplo simple:

```
edad := 20

if edad >= 18 {
    fmt.Println("Es mayor de edad")
}
```

Aquí ocurre lo siguiente:

- `edad >= 18` es una expresión booleana (bool)
- Si la condición es `true`, Go ejecuta el bloque
- Si es `false`, el bloque se ignora y el programa continúa

Como `edad` vale `20`, y `20` es mayor o igual que `18`, se mostrará el mensaje por pantalla.

# Condiciones booleanas

Go es deliberadamente estricto con las condiciones: solo acepta expresiones de tipo bool. No hay valores implícitos ni atajos. O la condición es booleana, o el código no compila.

Esto **NO** compila en Go, porque `x` es de tipo `int`, y por tanto no es de tipo `bool`.

```
x := 10

if x { // Error: non-boolean condition in if statement
    fmt.Println("x es distinto de cero")
}
```

La solución correcta sería esta:

```
if x != 0 {
    fmt.Println("x es distinto de cero")
}
```

Y esto tampoco compila en Go, porque `s`es de tipo `string`, por lo que tampoco es un `bool`.

```
s := "hola"

if s { // Error: non-boolean condition in if statement
}
```

Aquí la solución correcta sería esta:

```
if s != "" {
    fmt.Println("string no vacío")
}
```

Este diseño elimina ambigüedades y obliga a expresar la intención con claridad.

# if y bloques: unidad inseparable

En Go, las llaves nunca son opcionales, incluso si el bloque contiene una sola instrucción:

```
if x > 0 {
    fmt.Println(x)
}
```

Esta obligación de usar bloques no es un detalle menor:

- Hace visibles los límites de cada decisión
- Refuerza la idea de que if controla bloques, no líneas

# La alternativa else

Cuando queremos definir qué ocurre si la condición no se cumple, usamos `else`:

```
if edad >= 18 {
    fmt.Println("Adulto")
} else {
    fmt.Println("Menor de edad")
}
```

Aquí hay dos bloques claramente delimitados:

- Bloque del `if`: se ejecuta si la condición es verdadera
- Bloque del `else`: se ejecuta si la condición es falsa

Uno y solo uno de los dos bloques se ejecutará.

Go no ofrece operador ternario (`?:`) que ofrecen otros lenguajes como C/C++. La decisión siempre se expresa mediante bloques explícitos.

# else if: múltiples caminos

Cuando hay más de dos posibilidades, se encadenan condiciones usando `else if`:

Ejemplo:

```
nota := 7

if nota >= 9 {
    fmt.Println("Sobresaliente")
} else if nota >= 7 {
    fmt.Println("Notable")
} else if nota >= 5 {
    fmt.Println("Aprobado")
} else {
    fmt.Println("Suspenso")
}
```

Reglas importantes:

- Las condiciones se evalúan en orden.
- Solo se ejecuta el primer bloque cuya condición sea verdadera, el resto se ignoran.
- El `else` final es opcional, pero recomendable si cubre el resto de casos

Cada rama tiene su propio bloque, con su propio ámbito.

# Inicialización local en if

Una característica muy habitual en Go es la posibilidad de declarar variables locales al `if`.

Sintaxis general:

```
if inicializacion; condicion {
    // uso de la variable
}
```

Ejemplo:

```
if longitud := len(s); longitud > 0 {
    fmt.Println("El string no está vacío")
}
```

Aquí ocurre algo importante:

- `longitud` se declara e inicializa antes de evaluar la condición.
- Su ámbito queda limitado al `if` y a cualquier `else` asociado.
- Fuera de la estructura `if`, la variable no existe.

Este patrón conecta directamente con el concepto de [bloques y ámbito](/post/2026/golang-block-scope) visto en un artículo anterior.

Usar inicialización local en `if` permite:

- Reducir el ámbito de las variables al mínimo necesario.
- Evitar reutilizaciones accidentales.
- Mantener el código más claro y autocontenido.

Limitar el ámbito de las variables facilita la comprensión del flujo y evita conflictos con nombres de otras variables. Es un rasgo distintivo del estilo Go y aparece constantemente en código real.

# Errores comunes con if

Algunos errores frecuentes al empezar con `if` en Go:

Usar valores no booleanos como condición:

```
if x { } // inválido
```

Olvidar las llaves del bloque:

```
if x > 0
    fmt.Println(x) // inválido
```

Declarar variables fuera sin necesidad:

```
n := len(s)
if n > 0 {
    fmt.Println(n)
}
```

Es mejor usar una inicialización local:

```
if n := len(s); n > 0 {
    fmt.Println(n)
}
```

# Resumen mental

- `if` decide si se ejecuta un bloque
- Las condiciones son siempre `bool`
- Las llaves son obligatorias
- `else` define el camino alternativo
- `else if` permite múltiples decisiones
- La inicialización local reduce el ámbito de las variables
- Todo encaja con el modelo de bloques y ámbito de Go

# Conclusión

El control de flujo en Go no busca ser ingenioso, sino predecible y explícito. La sentencia `if` combina condiciones y bloques de forma directa, sin conversiones implícitas ni atajos confusos.

Si entiendes bien cómo funcionan los bloques y cómo `if` los activa o los omite, ya tienes una base sólida para razonar sobre el comportamiento de cualquier programa Go.

En el siguiente artículo daremos el paso natural: la estructura `switch`, que permite evaluar un valor frente a múltiples opciones de forma clara y ordenada, manteniendo siempre la relación explícita entre condiciones y bloques de instrucciones.

Si este artículo te ha resultado útil, si te ha surgido alguna duda o simplemente te apetece comentar que estas aprendiendo Go, te invito a unirte al [canal de Telegram](https://t.me/lateclaescape). Es un espacio abierto y gratuito donde compartimos conocimiento, resolvemos dudas y hablamos sobre desarrollo de software, ideas y proyectos reales, siempre con ganas de aprender y mejorar juntos.

¡Nos vemos en el próximo articulo!

Pulso la tecla `ESC:wq!`
