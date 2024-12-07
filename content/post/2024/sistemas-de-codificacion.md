---
title: Sistemas de codificación
date: 2024-01-19
image: /img/posts/coding.webp
categories: ["tecnología", "matematicas"]
tags: ["decimal", "hexadecimal", "ascii", "binario", "base64", "base58" ]
draft: false
featured: true
---

# Motivación

Cuando usamos un idioma, lo que estamos haciendo es representar información utilizando un conjunto de símbolos (alfabeto) que se combinan siguiendo unas determinadas reglas. En nuestro día a día, estamos usando sistemas de codificación continuamente. Los idiomas (castellano, inglés, alemán, ruso, etc), el código morse, el código braille, las señales de tráfico, los jeroglíficos, las partituras de música, los códigos de barras, los sistemas de numeración. Todos ellos son sistemas de codificación.

En este artículo me centro en explicar algunos de los sistemas de codificación mas usados en informática. En concreto, hablaré sobre estos 6 sistemas de codificación:

* Decimal
* Binario
* Hexadecimal
* ASCII
* Base64
* Base58

## Sistema decimal

El sistema decimal es el sistema de codificación mas ampliamente utilizado para representar números. Es un sistema de tipo posicional que utiliza un alfabeto limitado a los 10 dígitos. De ahí su nombre.

```
Alfabeto: {0123456789}
```

Las cantidades se representan utilizando como base aritmética las potencias del número 10 elevadas a su posición. Por ejemplo, veamos como se codifica el numero cincuenta y un mil novecientos sesenta y seis en base 10:

```
5*10^4  + 1*10^3  + 9*10^2  + 6*10^1  + 6*10^0 =
5*10000 + 1*1000  + 9*100   + 6*10    + 6*1    = 51966
```

Como vemos, el valor 51966 codifica al número cincuenta y un mil novecientos sesenta y seis en base 10.

## Sistema binario

El sistema binario es el sistema de codificación mas ampliamente utilizado por los sistemas informáticos para representar números. También es un sistema de tipo posicional, pero utiliza un alfabeto mucho mas reducido compuesto únicamente por 2 dígitos. De ahí su nombre:

```
Alfabeto: {01}
```

Cada dígito del sistema binario recibe el nombre de bit.

Las cantidades se representan utilizando como base aritmética potencias del numero 2 elevadas a su posición. Por ejemplo, veamos como se codifica el numero cincuenta y un mil novecientos sesenta y seis en base 2:

```
1*2^15  + 1*2^14  + 0*2^13  + 0*2^12  + 1*2^11  + 0*2^10  + 1*2^9  + 0*2^8  + 1*2^7  + 1*2^6  + 1*2^5  + 1*2^4  + 1*2^3  + 1*2^2  + 1*2^1  + 0*2^0 =
1*32768 + 1*16384 + 0*8192  + 0*4096  + 1*2048  + 0*1024  + 1*512  + 0*256  + 1*128  + 1*64   + 1*32   + 1*16   + 1*8    + 1*4    + 1*2    + 0*1   = 51966
```

Como vemos, el valor b1100101011111110 codifica al número cincuenta y un mil novecientos sesenta y seis en base 2. El prefijo 'b' se añade de forma artificial para que quede claro que se trata de un dígito codificado en binario (base 2) y evitar ambigüedades (110 es un número en base 10 y b110 es un numero en base 2).

Simplificando mucho la realidad se puede afirmar sin mentir que un sistema informático funciona con dos estados de la corriente eléctrica: presencia y ausencia de corriente. Los sistemas de codificación binaria (con dos estados cero y uno), encajan perfectamente con el funcionamiento de una máquina.

Pero nosotros, pobrecitos seres humanos, tenemos serias y evidentes dificultades para asimilar y procesar secuencias largas de ceros y unos. Nuestro cerebro no funciona como el de una máquina y nos cuesta procesar esta información correctamente.

## Sistema hexadecimal

Para que los humanos podamos leer mejor los números que entienden los sistemas informáticos, inventamos el sistema de codificación hexadecimal. El sistema hexadecimal, al igual que el decimal y que el binario, es un sistema posicional, pero utiliza un alfabeto mas extenso formado por 16 símbolos. De ahí su nombre:

```
Alfabeto: {0123456789abcdef}
```

Las cantidades se representan utilizando como base aritmética las potencias del numero 16 elevadas a su posición. Por ejemplo, veamos como se codifica el numero cincuenta y un mil novecientos sesenta y seis en base 16:

```
c*16^3  + a*16^2  + f*16^1  + e*16^0 =
c*4096  + a*256   + f*16    + e*1    =
49152   + 2560    + 240     + 14     = 51966
```

Como vemos, el valor 0xcafe codifica al número cincuenta y un mil novecientos sesenta y seis en base 16. El prefijo '0x' se añade de forma artificial para que quede claro que es un dígito codificado en base 16 y evitar ambigüedades (el café es una bebida de origen colombiano, pero el 0xcafe es un número en base 16).

Cualquier numero expresado en hexadecimal se puede convertir a binario de forma muy sencilla utilizando una sencilla transformación:

```
0 = 0000    1 = 0001    2 = 0010    3 = 0011
4 = 0100    5 = 0101    6 = 0110    7 = 0111
8 = 1000    9 = 1001    a = 1010    b = 1011
c = 1100    d = 1101    e = 1110    f = 1111
```

Vemos como 0xcafe sería una c (1100), una a (1010) una f (1111) y una e (1110). Si lo juntamos todo, tenemos el número b1100101011111110 codificado en base 2.

## ASCII

El sistema de codificación ASCII (American Standard Code for Information Interchange) permite convertir el texto que escribimos en un sistema informático en bytes (secuencias de 8 bits) sin ninguna restricción. Por tanto, utiliza un alfabeto compuesto por todas las posibles combinaciones de 8 bits (2^8 = 256), numeradas desde el 0 hasta el 255. Muchos de esos caracteres no tienen una representación printable en pantalla. Por ello no pondré la lista completa.


```
Alfabeto: {bytes desde el 0 hasta el 255}
```

La conversión de texto a ASCII se hace utilizando una tabla de traducción directa, que asigna un numero de 8 bits (de 0 a 255) a cada símbolo que puedes escribir en un teclado. Los valores mas habituales los puedes consultar en esta tabla en notación decimal:

```
  30 40 50 60 70 80 90 100 110 120
----------------------------------
0:    (  2  <  F  P  Z  d   n   x
1:    )  3  =  G  Q  [  e   o   y
2:    *  4  >  H  R  \  f   p   z
3: !  +  5  ?  I  S  ]  g   q   {
4: "  ,  6  @  J  T  ^  h   r   |
5: #  -  7  A  K  U  _  i   s   }
6: $  .  8  B  L  V  `  j   t   ~
7: %  /  9  C  M  W  a  k   u  DEL
8: &  0  :  D  N  X  b  l   v
9: '  1  ;  E  O  Y  c  m   w
```

Si por ejemplo queremos convertir la cadena de texto "cafe" en ASCII, tenemos que:

- la 'c' es el decimal  99 que se traduce en el binario 01100011
- la 'a' es el decimal  97 que se traduce en el binario 01100001
- la 'f' es el decimal 102 que se traduce en el binario 01100110
- la 'e' es el decimal 101 que se traduce en el binario 01100101

Por tanto el sistema informático traduce la cadena de texto "cafe" en esta secuencia de bits en binario:

```
01100011 01100001 01100110 01100101
```

Si no existiera el código ASCII, difícilmente podrías estar leyendo este documento ahora mismo.

## Base64

El protocolo de transmisión de correos electrónicos SMTP funciona exclusivamente con texto imprimible. Lo mismo ocurre con algunos formatos de documentos tipo XML o JSON. Para adjuntar documentos binarios (docs, imágenes, fotos o vídeos) en un correo electrónico, o para incrustar documentos binarios en un XML o JSON, es necesario codificar los bytes de esos documentos en un formato de texto imprimible. Para ello se inventa el sistema de codificación en base64, que utiliza un alfabeto de 64 símbolos. De ahí su nombre:

```
Alfabeto: {ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/}
```

Estos 64 símbolos se pueden codificar empleando solamente 6 bits (2 ^ 6 = 64). El alfabeto de base64 se elige expresamente para incluir todos los caracteres alfanuméricos printables (letras MAYÚSCULAS, letras minúsculas y dígitos), junto con dos símbolos: suma '+' y división '/'.

El sistema de codificación va tomando de la entrada grupos de 6 bits y utiliza la tabla de conversión que incluyo aquí debajo para traducirlo en el carácter de salida equivalente:

```
    0 10 20 30 40 50 60
-----------------------
0:  A  K  U  e  o  y  8
1:  B  L  V  f  p  z  9
2:  C  M  W  g  q  0  +
3:  D  N  X  h  r  1  /
4:  E  O  Y  i  s  2
5:  F  P  Z  j  t  3
6:  G  Q  a  k  u  4
7:  H  R  b  l  v  5
8:  I  S  c  m  w  6
9:  J  T  d  n  x  7
```

Así por ejemplo, para convertir la cadena de texto "cafe" en Base64, primero tenemos que convertirla en ASCII. Es necesario usar grupos de 8 bits, por lo que si algún símbolo ASCII es de menos bits, hay que añadir ceros a la izquierda.

```
01100011 01100001 01100110 01100101
```

Después re-agrupar la secuencia de bits en grupos de 6 bits, empezando por el bit mas a la izquierda:

```
011000 110110 000101 100110 011001 01
```

Si queda algún grupo con menos de 6 bit, lo completamos con ceros a su derecha hasta tener 6 bits en total:

```
011000 110110 000101 100110 011001 010000
```

Por cada grupo de 6 bits aplicamos la conversión que indica la tabla anterior:

- El grupo (011000) representa el número decimal 24, y la tabla lo convierte en el carácter 'Y'
- El grupo (110110) representa el número decimal 54, y la tabla lo convierte en el carácter '2'
- El grupo (000101) representa el número decimal  5, y la tabla lo convierte en el carácter 'F'
- El grupo (100110) representa el número decimal 38, y la tabla lo convierte en el carácter 'm'
- El grupo (011001) representa el número decimal 25, y la tabla lo convierte en el carácter 'Z'
- El grupo (010000) representa el número decimal 25, y la tabla lo convierte en el carácter 'Q'

De momento nos queda esta cadena de salida codificada en base64:

```
Y2FmZQ
```

Para finalizar, la definición de base64 obliga a que la longitud de la cadena de salida sea múltiplo de 4 (4, 8, 12, ...). Si no tenemos esa suerte, completamos la cadena de salida añadiendo caracteres de relleno (pads), tantos como sean necesarios para conseguir que la longitud de la cadena de salida sea múltiplo de 4. El carácter de relleno elegido por el estándar es el '=', un carácter especial que no forma parte del alfabeto de base64. De esta manera, el decodificador sabrá que son caracteres de relleno que deben ser eliminados. En nuestro ejemplo en concreto tenemos una salida de 6 caracteres (Y2FmZQ), por lo que debemos añadir dos caracteres de relleno para que el número de caracteres sea múltiplo de 4. Quedando esta conversión:

```
Y2FmZQ==
```

Esto hace que cualquier valor codificado en base 64 sea imprimible, lo que permite que se puedan visualizar con un editor de textos, eludiendo los problemas que aparecen en transmisiones de datos usando el protocolo SMTP con caracteres especiales, o en el manejo de ficheros binarios incrustados en XML o JSON.

## Base58

Base58 es un formato para codificar cualquier dato binario en una cadena de texto, que en lugar de utilizar un alfabeto de 64 caŕacteres como hace base64, utiliza uno de solo 58 símbolos que han sido cuidadosamente elegidos para funcionar bien en entornos donde una persona deba confirmar visualmente la información codificada sin errores. De ahí su nombre.

```
Alfabeto: {ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz123456789}
```

Base58 fue diseñado teniendo en cuenta una serie de cualidades que base64 no tuvo. Son las siguientes:

1. Se eliminan del alfabeto de base64 el 0 (numero cero), la O (letra o mayúscula), la l (letra L minúscula), la I (letra i mayúscula). Estos 4 caracteres generan confusión al ojo humano. ¿Quien no ha confundido en mas de una ocasión una l con una 1, o un 0 con una O?.
2. Se eliminan los símbolos no alfanuméricos: la suma '+', la división '/' y el igual '='. Esto posibilita incluir el texto codificado en base58 en una URL sin necesidad de usar esquemas de codificación adicionales.
3. Al ser todo caracteres alfanuméricos, se facilita que el doble clic seleccione toda la dirección como una sola palabra.
4. A diferencia de base64, base58 no utiliza bytes de padding, lo que hace que los valores codificados en base58 sean mas cortos que los equivalentes en base64.

El método usado para codificar en base58 es un poco mas complicado de explicar. Afortunadamente en Linux tenemos herramientas que hacen el trabajo sucio por nosotros. Para codificar nuestra cadena de ejemplo "cafe" en base58, usaremos este sencillo comando:

```
$ echo -ne "cafe" | base58
3YLVQQ
```

# Despedida

Soy consciente que el contenido de este articulo puede aburrir a la inmensa mayoría de los mortales, pero era necesario para aclarar ciertos conceptos antes de abordar asuntos mucho mas interesantes. De momento me despido hasta el próximo articulo. Gracias por leerme. ¡Nos vemos muy pronto!

Pulso la tecla ESC, dos puntos wq!

