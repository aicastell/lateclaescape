---
title: Criptografía clásica
date: 2024-02-02
image: "/img/posts/classic-cryptografy.webp"
categories: [ "criptografía", "ciberseguridad" ]
tags: [ "criptografia clasica", "cifrado", "encriptación", "cifrado cesar" ]
draft: false
featured: true
---

# Criptografía

El término criptografía proviene del griego "kryptós" o secreto y "grafo" o escritura. Sus raíces se pueden rastrear hasta civilizaciones antiguas como la egipcia y la romana, pero su evolución ha sido continua a lo largo del tiempo.

La criptografía abarca una amplia gama de métodos de cifrado, desde cifrados clásicos hasta técnicas avanzadas basadas en principios matemáticos y computacionales.

En este articulo hablaré sobre criptografía clásica. En artículos posteriores abordaré la criptografía moderna.

## Criptografía clásica

La criptografía clásica hace referencia a los métodos de cifrado inventados **antes de la aparición de los primeros ordenadores**. Estas técnicas se caracterizan por su simplicidad y la falta de complejidad matemática. Al ser fáciles de entender, son muy didácticas y ayudan a explicar y a comprender como funciona la criptografía.

Fundamentalmente podemos distinguir dos tipos de cifrado clásico:

- Cifrado por sustitución
- Cifrado por trasposición

### Cifrado por sustitución

El cifrado por sustitución es una técnica de criptografía que implica reemplazar cada letra del alfabeto por otra distinta, utilizando un método consistente a lo largo de todos los caracteres del mensaje.

Un ejemplo de cifrado por sustitución es el conocido como **método de Cesar**. Con éste método, cada carácter del mensaje en claro es sustituido por el situado K > 0 posiciones mas adelante en el alfabeto. Si tomamos como clave K=4, el criptosistema reemplaza la A por la E, la B por la F, y así sucesivamente. El descifrado es igual de fácil, ya que consiste en sustituir cada carácter del mensaje cifrado por el situado K posiciones atrás en el alfabeto. Veamos un ejemplo:

```
Mensaje: E L P E R R O D E S A N R O Q U E T I E N E R A B O
  Clave: 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
Cifrado: I P T I V V S H I W E R V S U Y I X M I R I V E F S
```

El método de Cesar utiliza la misma clave K tanto para cifrar como para descifrar el mensaje. Aplicando la clave K sobre el mensaje original, obtenemos el mensaje cifrado. Aplicando la misma clave K sobre el mensaje cifrado, obtenemos el mensaje original.

El método de César lleva el nombre del emperador romano Julio César, quien se cree que utilizó este criptosistema para transmitir mensajes confidenciales al frente de batalla, sin que el enemigo pudiera descifrar el contenido de los mensajes interceptados.

### Cifrado por trasposición

A diferencia de los cifrados por sustitución, donde se reemplazan los caracteres, el cifrado por trasposición es una técnica criptográfica que implica alterar el orden de los elementos en el mensaje original, sin alterar los elementos en sí mismos.

Un ejemplo de cifrado por trasposición es el **método por trasposición simple**. Con éste método se permutan las posiciones de las letras en bloques consecutivos de texto. Si tomamos bloques de 5 caracteres y usamos como clave K = (5,2,1,3,4), podemos reordenar los bloques del mensaje original de esta manera:

```
Mensaje: E L P E R | R O D E S | A N R O Q | U E T I E | N E R A B | O _ _ _ _
  Clave: 5 2 1 3 4 | 5 2 1 3 4 | 5 2 1 3 4 | 5 2 1 3 4 | 5 2 1 3 4 | 5 2 1 3 4
Cifrado: P L E R E | D O E S R | R N O Q A | T E I E U | R E A B N | _ _ _ _ O
```

Vemos como el cifrado por transposición implica reorganizar las posiciones de los caracteres o bloques de texto en el mensaje original. Utilizando el mismo tamaño de bloque (5) y la misma clave K, en sentido inverso, obtenemos el mensaje original.

## Despedida

La criptografía clásica se fundamenta en técnicas efectivas pero laboriosas, ya que su seguridad depende en gran medida de la complejidad de los métodos de sustitución y de transposición empleados. Históricamente, se ha utilizado en contextos militares, donde la rapidez y la simplicidad eran esenciales. En el frente de batalla, los soltados necesitaban cifrar y descifrar mensajes de manera ágil, lo que exigía que el método utilizado fuera fácil de recordar y aplicar. Estas características convierten a los sistemas clásicos en muy débiles y fáciles de atacar.

En contraste con la criptografía clásica, surge el concepto de **criptografía moderna** con la creación de las primeras computadoras. Si te gusta la seguridad informática, abordaré este asunto en próximos artículos. Así que, ¡no te lo pierdas!.

Confío en que hayas comprendido como funciona la criptografía, una disciplina que a pesar de su aparente complejidad, se fundamenta en conceptos elementales muy simples. Me sentiré satisfecho si llegado a este punto, has adquirido algún conocimiento nuevo sobre esta materia. Por supuesto, te animo a preguntar en el [canal de Telegram](https://t.me/lateclaescape) si te queda alguna duda pendiente. Intentaré ayudarte a resolverla. Gracias por leerme y nos vemos en el siguiente articulo.

Pulso la tecla ESC, dos puntos wq!
