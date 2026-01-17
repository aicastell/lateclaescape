---
title: Criptografía asimétrica
date: 2024-02-29
image: "/img/posts/asymmetric-cryptography.webp"
categories: [ "criptografía" ]
tags: [ "asimetrica", "firma_digital", "mitm" ]
draft: false
featured: true
---

# Criptografía asimétrica

La criptografía asimétrica, también conocida como criptografía de clave pública, implica el uso de dos claves, una pública y otra privada:

- K_PUB (clave publica)
- K_PRI (clave privada)

## Propiedades de las claves asimétricas

Las claves asimétricas tienen 2 propiedades:

- Relacionadas matemática
- Computacionalmente irreversibles

El par de claves pública y privada están relacionadas matemáticamente. A partir de la clave privada se puede derivar la clave pública fácilmente, siguiendo un proceso matemático específico.

El método utilizado para generar la clave publica a partir de la clave privada es computacionalmente irreversible. Esto significa que es extremadamente difícil o prácticamente imposible calcular la clave privada a partir de la clave publica en un periodo de tiempo razonable con los recursos computacionales disponibles.

## Gestión de las claves

Las clave publica (K_PUB) es pública por definición. Puedes distribuirla ampliamente, publicarla en sitios web, o enviarla por canales de comunicación inseguros sin preocuparte por su seguridad. Todo el mundo puede verla sin peligro alguno.

La clave privada (K_PRI) es confidencial y debe guardarse de manera segura. Solo el propietario legítimo de la clave privada debe conocerla. Su exposición a terceros o al público en general comprometería la seguridad del sistema.

## Algoritmos de clave asimétrica

Todos los algoritmos criptográficos que utilizan un par de claves K_PUB y K_PRI se conocen como **algoritmos de clave asimétrica**. En la actualidad existen multitud de algoritmos criptográficos de clave asimétrica, aunque los mas conocidos son estos tres:

- RSA (Rivest-Shamir-Adleman)
- DSA (Digital Signature Algorithm)
- ECC (Elliptic Curve Cryptography)

Los algoritmos asimétricos tienden a ser mas lentos que los algoritmos simétricos, debido a 2 motivos:

- dificultad computacional mas elevada
- tamaño de clave más grande

Las operaciones matemáticas involucradas son más complejas en comparación con los algoritmos simétricos. RSA se basa en la dificultad de factorizar grandes números enteros en sus factores primos. DSA se basa en operaciones de exponentes modulares. Y ECC se basa en operaciones realizadas en una curva elíptica algebraica sobre un cuerpo finito. Estas operaciones son mucho mas complejas que las simples sustituciones o permutaciones que realizan los algoritmos simétricos.

Los algoritmos asimétricos requieren claves mucho más grandes para proporcionar el mismo nivel de seguridad que los algoritmos simétricos. Por ejemplo, las claves RSA típicamente tienen longitudes de clave de 4096 bits o más. Mientras que las claves simétricas como AES utilizan longitudes de clave de 256 bits. El procesamiento de claves más grandes requiere más recursos computacionales.

## Encriptar y desencriptar

![asymetric schema](/img/asymmetric-cryptography-schema.webp)

Para enviar un mensaje M encriptado, se utiliza la clave publica K_PUB del receptor, conocida por todo el mundo, y la función asimétrica ASYM_ENCRYPT:

```
ASYM_ENCRYPT(K_PUB, M) = ME
```

El mensaje encriptado ME solo puede ser desencriptado por el receptor utilizando la función asimétrica ASYM_DECRYPT y la clave privada K_PRI, que solamente conoce el propio receptor:

```
ASYM_DECRYPT(K_PRI, ME) = M
```

Por tanto, se cumple esta propiedad:

```
ASYM_DECRYPT(K_PRI, ASYM_ENCRYPT(M_PUB, M)) = M
```

Es decir, el mensaje M encriptado con la clave pública (es decir ME) se puede desencriptar con la clave privada, para obtener de nuevo el mensaje M.

## Ejemplo

Veamos un ejemplo sencillo fácil de entender por todo el mundo.

Volvamos al ejemplo de Alice y Bob. Alice y Bob son dos buenos amigos que un buen día se conocieron por Internet. Intentaron comunicarse de forma segura usando criptografía simétrica, pero descubrieron que alguien (Eva) había interceptado sus comunicaciones realizando un ataque MITM. Tras recuperar su bonita amistad, han decidido cambiar su estrategia para comunicarse de forma segura. Esta vez van a usar criptografía asimétrica para enviarse mensajes secretos.

Bob genera en el ordenador de su casa un par de claves asimétricas:

- K_BOB_PUB
- K_BOB_PRI

Bob envía un mensaje por Whatsapp a Alice que contiene K_BOB_PUB, su clave publica.

Un buen día por la mañana, Alice quiere mandarle un mensaje secreto a Bob. Alice genera el mensaje M con este contenido:

```
M = "La semana que viene viajo de nuevo a tu pais"
```

Alice utiliza la función ASYM_ENCRYPT del algoritmo de clave asimétrica, usando la clave pública de Bob K_BOB_PUB para encriptar el mensaje M:

```
ASYM_ENCRYPT(K_BOB_PUB, "La semana que viene viajo de nuevo a tu pais") = "AuX4TKMrgOrx"
```

Alice envía el mensaje encriptado "AuX4TKMrgOrx" a Bob.

Cuando Bob recibe el mensaje encriptado, utiliza la función asimétrica ASYM_DECRYPT junto con su clave privada K_BOB_PRI para desencriptarlo:

```
ASYM_DECRYPT(K_BOB_PRI, "AuX4TKMrgOrx") = "La semana que viene viajo de nuevo a tu pais"
```

Bob acaba de ver el mensaje original que le ha enviado Alice. Nadie mas que Alice y Bob conocen el contenido de ese mensaje. Alice lo conoce porque lo ha generado. Y Bob lo conoce porque es la única persona del mundo que tiene la clave privada K_BOB_PRI con la que se puede desencriptar cualquier mensaje encriptado con su clave publica K_BOB_PUB.

## Problemas de la criptografía asimétrica

Pudiera parecer que la criptografía asimétrica resuelve el problema de compartir la clave a través de un canal inseguro como Internet. Pero siento decepcionarte. La criptografía asimétrica tampoco resuelve el problema por si sola. Y es que la criptografía asimétrica también es vulnerable a ataques MITM.

Un atacante en medio del canal, podría generar su propio par de claves publica y privada. Cuando el receptor envía su clave publica al emisor, el atacante podría interceptar esa comunicación, y reemplazar la clave publica legitima del receptor por la propia del atacante.

### Ejemplo de ataque MITM

Veamos un ejemplo de ataque MITM con criptografía asimétrica:

Alice y Bob son dos buenos amigos que están usando criptografía asimétrica para enviarse mensajes secretos.

Bob ha generado en el ordenador de su casa un par de claves asimétricas:

- K_BOB_PUB
- K_BOB_PRI

Eva, que es una chica muy lista, ha generado en su propio ordenador otro par de claves asimétricas fraudulentas que va a utilizar para el ataque:

- K_MITM_PUB
- K_MITM_PRI

Bob envía un mensaje por Whatsapp a Alice, para compartir su clave publica. Pero Internet es un canal inseguro, y Bob no toma ninguna medida para garantizar que la clave pública enviada es auténtica y pertenece realmente a él.

El mensaje con la clave pública K_BOB_PUB es interceptado por Eva. Eva se guarda una copia de la clave K_PUB_BOB. Y reenvía la clave fraudulenta K_MITM_PUB a Alice. Alice cree erróneamente que K_MITM_PUB es la verdadera clave publica de Bob.

Un buen día por la mañana, Alice quiere mandarle un mensaje secreto a Bob. Alice genera el mensaje M con este contenido:

```
M = "La semana que viene viajo de nuevo a tu pais"
```

Alice utiliza la función ASYM_ENCRYPT del algoritmo de clave asimétrica, usando K_MITM_PUB, la supuesta clave pública de Bob, para encriptar el mensaje M:

```
ASYM_ENCRYPT(K_MITM_PUB, "La semana que viene viajo de nuevo a tu pais") = "FtaSyT4bvO8jQ"
```

Alice envía el mensaje encriptado "FtaSyT4bvO8jQ" a Bob.

Eva intercepta de nuevo el mensaje encriptado. Y como posee la clave privada K_MITM_PRI, puede desencriptarlo:

```
ASYM_ENCRYPT(K_MITM_PRI, "FtaSyT4bvO8jQ") = "La semana que viene viajo de nuevo a tu pais"
```

Eva decide manipular el mensaje, reemplazando el mensaje original M por un mensaje M' alterado:

```
M' = "Nunca vuelvas a escribirme"
```

Eva vuelve a encriptar el mensaje M' con la clave publica original de Bob:

```
ASYM_ENCRYPT(K_PUB, "Nunca vuelvas a escribirme") = "Ytq85NBjRoN"
```

Cuando Bob recibe el mensaje encriptado, utiliza la función asimétrica ASYM_DECRYPT junto con su clave privada K_BOB_PRI para desencriptarlo:

```
ASYM_DECRYPT(K_PRI, "Ytq85NBjRoN") = "Nunca vuelvas a escribirme"
```

Bob siente una gran decepción. No sabe que Eva ha manipulado el mensaje M. La buena relación entre Alice y Bob corre mas peligro que nunca.

El problema real es que el emisor del mensaje no tiene manera alguna de saber con exactitud que la clave publica del receptor es en realidad la suya, y no es la de un atacante MITM. El atacante MITM se apropia de la personalidad del receptor. Y ni el emisor ni el receptor se darán nunca cuenta de dicha situación.

## Conclusión

En este articulo has aprendido como funcionan los algoritmos de criptografía asimétrica. Has visto como funciona un ataque MITM para un algoritmo asimétrico. Por tanto, has entendido que el problema principal es que el emisor del mensaje no tiene manera alguna de saber con exactitud que la clave publica del receptor es en realidad la suya, y no la de un atacante MITM. Veremos en próximos artículos como se puede hacer esto de forma segura. Si te gusta la seguridad informática, ¡no te pierdas los próximos artículos!

Espero haberte aclarado conceptos que a menudo resultan complejos y que la literatura no siempre explica de forma clara y concisa. Si con este post he podido aclarar alguna duda, me daré por satisfecho. Y por supuesto, si os queda alguna duda pendiente, no dudéis en formularla por el [canal de Telegram](https://t.me/lateclaescape) e intentaré ayudaros a resolverla. Gracias por leerme y nos vemos en el siguiente articulo.

Pulso la tecla `ESC:wq!`
