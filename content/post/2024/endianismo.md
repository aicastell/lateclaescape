---
title: Endianismo
date: 2024-01-19
image: "/img/posts/la-tecla-esc.jpg"
categories: [ "tecnología" ]
tags: [ "decimal", "hexadecimal", "ascii", "binario", "base64", "base58" ]
draft: true
featured: true
---










 Endianismo (Little Endian vs Big Endian)
=== Introducción ===

El endianismo es un concepto que hace referencia a como la arquitectura de un procesador mapea un valor escalar en una secuencia de bytes en memoria. Existen dos maneras distintas de mapear un valor escalar en memoria, y se conocen con estos nombres:

    * Big Endian
    * Little Endian

En este post explicamos como funciona cada una de ellas. Pero para poder explicar la diferencia entre Little y Big Endian, primero hay que entender los conceptos LSB y MSB, que paso a explicar a continuación:


=== LSB vs MSB ===

Los valores escalares se agrupan en secuencias de varios bytes. Por ejemplo, en la arquitectura x86, un "short int" ocupa 2 bytes, un "unsigned int" ocupa 4 bytes, un "double" ocupa 8 bytes y un "long double" ocupa 16 bytes.

La secuencia de bytes de un valor escalar se ordena en función del peso de sus bytes dentro del escalar. Dos bytes tienen un significado especial en esa ordenación:

    * LSB o byte menos significativo (Less Significant Byte)
    * MSB o byte mas significativo (Most Significant Byte)

El siguiente gráfico representa la secuencia de 8 bytes de un escalar de tipo "double" y la posición de los bytes LSB y del MSB dentro de dicha secuencia.

          7                           0
        +---+---+---+---+---+---+---+---+
        |MSB|   |   |   |   |   |   |LSB|
        +---+---+---+---+---+---+---+---+

Por ejemplo, si tenemos un escalar de tipo "unsigned int", con valor 0x1a2b3c4d, tendremos que el byte de mayor peso (MSB) es 0x1a, y el byte de menor peso (LSB) es 0x4d. El resto de los bytes se ordenan en función de LSB y MSB.



=== Little Endian vs Big Endian ===

Entendida la diferencia entre MSB y LSB, solo queda explicar la diferencia fundamental entre la representación Little Endian y la representación Big Endian, que ya avanzo en el siguiente gráfico:


= Little Endian =

En little-endian, el byte con la dirección de memoria mas baja se corresponde con el byte LSB. Por ejemplo:

    long int v = 0x0A0B0C0D;

    base_addr     = 0x0D // LSB
    base_addr + 1 = 0x0C
    base_addr + 2 = 0x0B
    base_addr + 3 = 0x0A // MSB

Los procesadores de Intel (los PC's) son sistemas Little Endian.


= Big Endian =

En big-endian, el byte con la dirección de memoria mas baja se corresponde con el MSB. Por ejemplo:

    long int v = 0x0A0B0C0D;

    base_addr     = 0x0A // MSB
    base_addr + 1 = 0x0B
    base_addr + 2 = 0x0C
    base_addr + 3 = 0x0D // LSB

Los procesadores de Motorola (los MAC's) son sistemas Big Endian.


= Middle Endian =

Los procesadores ARM son capaces de usar tanto Big como Little Endian, es un parámetro que se establece durante la configuración de la cross-toolchain. Por ese motivo, los procesadores ARM se conocen como sistemas Middle Endian.


=== Cierre ===

En esta ocasión redacto este breve post de contenido bastante técnico con el único objetivo de usarlo como recordatorio personal, pues se trata de una cuestión que siempre que la reviso creo tener dominada y cuando pasa un tiempo, vuelvo a confundir el orden correcto de los bytes. Espero que esta sea la definitiva!

Y sobre todo, espero que el post le sirva de ayuda a mas gente para que pueda aclarar esta duda en alguna ocasión.

Espero que lo hayáis disfrutado. Hasta la próxima!! 
