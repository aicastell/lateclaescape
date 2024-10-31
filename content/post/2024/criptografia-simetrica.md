---
title: Criptografía simétrica
date: 2024-02-16
image: "/img/posts/symmetric-cryptography.webp"
categories: [ "criptografía" ]
tags: [ "simétrica", "mitm" ]
draft: false
featured: true
---

# Criptografía simétrica

La criptografía simétrica, también conocida como criptografía de clave privada, implica el uso de una clave única K, que permite tanto encriptar como desencriptar el mensaje.

- K (clave secreta)

## Propiedades de las claves simétricas

Las claves simétricas deben cumplir 4 propiedades para considerarse robustas y seguras:

- Longitud adecuada
- Aleatoria
- Secreta
- Resistente a ataques

Deben tener una longitud suficiente para proporcionar seguridad. Longitudes comunes incluyen 128, 192 y 256 bits.

Deben generarse de manera completamente aleatoria para evitar patrones predecibles.

Deben ser secretas, nadie mas que el emisor y el receptor del mensaje deben conocerla.

Deben ser resistentes a diversos tipos de ataques, incluidos de fuerza bruta, de diccionario, el análisis de frecuencias, o de canal lateral.

## Generación de la clave

Una clave simétrica puede generarse utilizando cualquier secuencia de bytes en el [sistema de codificación](/post/2024/sistemas-de-codificacion) que mas nos guste: binario, ASCII, hexadecimal, etc.

Sin embargo, para generar una clave simétrica robusta y segura, utilizaremos lo que se conoce como **generador de números aleatorios (RNG)**. Estos generadores pueden ser por software o por hardware, y suelen basarse en alguna fuente de entropía externa para garantizar la aleatoriedad de las claves generadas. Algunas fuentes de entropía de uso habitual son:

- el movimiento del ratón
- la pulsación de teclas random
- la actividad del disco duro
- el ruido eléctrico

El uso de los generadores de números aleatorios basados en entropía externa ayuda a garantizar que la clave generada sea lo más aleatoria, impredecible y segura posible.

## Gestión de las claves

Una vez generada la clave simétrica, es crucial realizar una buena gestión de la clave generada. Esto incluye aspectos como:

- intercambio seguro
- renovación periódica
- almacenamiento seguro

El intercambio seguro de claves secretas es un componente crítico de todos los sistemas criptográfico simétricos.

La renovación periódica de claves simétricas es esencial para mantener la seguridad de la información a largo plazo.

El almacenamiento de claves simétricas de forma segura es fundamental para evitar accesos no autorizados.

## Algoritmos de clave simétrica

Todos los algoritmos criptográficos que utilizan la misma clave K para encriptar y para desencriptar el mensaje se conocen como **algoritmos de clave simétrica**. En la actualidad existen multitud de algoritmos criptográficos de clave simétrica:

- AES (Advanced Encryption Standard)
- DES (Data Encryption Standard)
- Blowfish
- IDEA (International Data Encryption Algorithm)

La elección del algoritmo es fundamental, ya que no todos los algoritmos simétricos ofrecen el mismo nivel de seguridad. El mas utilizado en la actualidad es AES, que se considera altamente seguro. Blowfish e IDEA han quedado en desuso ante la popularidad de AES. DES ha quedado obsoleto, ya que utiliza una clave de 56 bits que con la capacidad computacional actual es fácilmente atacable por fuerza bruta.

Los algoritmos simétricos tienden a ser más rápidos que los algoritmos asimétricos. Esto se debe a que los algoritmos simétricos involucran operaciones simples y directas, como sustituciones y permutaciones, que pueden ejecutarse de manera eficiente en el hardware moderno.

## Encriptar y desencriptar

![symetric schema](/img/symmetric-cryptography-schema.webp)

Para encriptar un mensaje M con la clave K, usamos la función simétrica SYM_ENCRYPT:

```
SYM_ENCRYPT(K, M) = ME
```

Y para desencriptar un mensaje ME encriptado con la clave K, usamos la función simétrica SYM_DECRYPT:

```
SYM_DECRYPT(K, ME) = M
```

Por tanto, se cumple esta propiedad:

```
SYM_DECRYPT(K, SYM_ENCRYPT(K, M)) = SYM_DECRYPT(K, ME) = M
```

Es decir, el mensaje M encriptado con K (es decir ME) se puede desencriptar con K para obtener de nuevo el mensaje M.

### Ejemplo

Veamos un ejemplo sencillo que será fácil de entender por todo el mundo.

Alice y Bob son dos buenos amigos que viven en la misma ciudad. Un buen día deciden utilizar criptografía simétrica para enviarse mensajes secretos. Ambos quedan en persona para crear una clave K y compartirla para sus comunicaciones futuras:

```
K = "NUESTROSECRETO"
```

Un buen día por la mañana, Alice quiere mandar un mensaje secreto a Bob. Alice genera el mensaje M con este contenido:

```
M = "Nos vemos mañana en el cine"
```

Alice utiliza la función simétrica SYM_ENCRYPT para encriptar el mensaje M usando la clave "NUESTROSECRETO":

```
SYM_ENCRYPT("NUESTROSECRETO", "Nos vemos mañana en el cine") = "WQKRfVB1"
```

Alice envía el mensaje encriptado "WQKRfVB1" a Bob.

Cuando Bob recibe el mensaje encriptado, utiliza la función simétrica SYM_DECRYPT y la misma clave K = "NUESTROSECRETO" para desencriptarlo:

```
SYM_DECRYPT("NUESTROSECRETO", "WQKRfVB1") = "Nos vemos mañana en el cine"
```

Bob acaba de ver el mensaje original que le ha enviado Alice. Nadie mas que Alice y Bob conocen el contenido de ese mensaje, porque son los únicos que conocen la clave K.

## Problemas de la criptografía simétrica

La criptografía simétrica cumple los tres principios fundamentales de la seguridad informática (confidencialidad, integridad y autenticidad) si y solo si la clave K se genera y se comparte de manera segura entre el emisor y el receptor. Esto se consigue si el emisor y el receptor comparten la clave en persona, antes de iniciar las comunicaciones. Esta es la situación ideal.

Sin embargo, esta situación es poco habitual en la práctica. Los problemas surgen cuando el emisor y receptor intentan compartir la clave K a través de un canal inseguro como Internet. La clave K podría caer en manos de una tercera persona. Esta tercera persona podría realizar un ataque conocido como **MITM (Man In The Middle)**. El atacante se sitúa entre el emisor y el receptor. Actuando como un intermediario ilegítimo, intercepta y altera la comunicación entre las dos partes, quienes creen estar directamente conectados entre si.

### Ejemplo de ataque MITM

Veamos un ejemplo de ataque MITM con criptografía simétrica:

Alice y Bob son dos buenos amigos que se han conocido por Internet, pero viven en continentes diferentes. Un buen día deciden utilizar criptografía simétrica para enviarse mensajes secretos.

Alice genera la clave K:

```
K = "NUESTROSECRETO"
```

Alice envía la clave K a Bob por Internet. Pero Internet es un canal inseguro, y Alice no toma ninguna medida para enviar la clave K de forma segura.

El mensaje con la clave K es interceptado por Eva, quien se guarda una copia de la clave K. Eva reenvía la clave K a Bob, quien finalmente recibe la clave K. Ni Alice ni Bob saben que Eva tiene ahora una copia de la clave K.

Un buen día por la mañana, Alice quiere mandarle un mensaje secreto a Bob. Alice genera el mensaje M con este contenido:

```
M = "La semana que viene viajo a tu pais"
```

Alice utiliza la función simétrica SYM_ENCRYPT para encriptar el mensaje M usando la clave "NUESTROSECRETO":

```
SYM_ENCRYPT("NUESTROSECRETO", "La semana que viene viajo a tu pais") = "HxRomqRt"
```

Alice envía el mensaje encriptado "HxRomqRt" a Bob.

Eva intercepta el mensaje encriptado. Y como conoce la clave K, puede desencriptarlo:

```
SYM_DECRYPT("NUESTROSECRETO", "HxRomqRt") = "La semana que viene viajo a tu pais"
```

Eva decide manipular el mensaje, reemplazando el mensaje original M por un mensaje M' alterado:

```
M' = "Nunca voy a viajar a tu pais"
```

Eva vuelve a encriptar el mensaje M' con la misma clave K:

```
SYM_ENCRYPT("NUESTROSECRETO", "Nunca voy a viajar a tu pais") = "mT4VtDTXMJ"
```

Después, Eva envía el mensaje encriptado "mT4VtDTXMJ" a Bob.

Bob recibe el mensaje encriptado, y utiliza la función simétrica SYM_DECRYPT y la misma clave K = "NUESTROSECRETO" para desencriptarlo:

```
SYM_DECRYPT("NUESTROSECRETO", "mT4VtDTXMJ") = "Nunca voy a viajar a tu pais"
```

Bob siente una gran decepción. Y no sabe que Eva ha manipulado el mensaje M. La buena relación entre Alice y Bob corre ahora peligro.

## Conclusión

En este articulo has aprendido como funcionan los algoritmos de criptografía simétrica. Has visto como funciona un ataque MITM para un algoritmo simétrico. Y has entendido por qué compartir la clave secreta K entre el emisor y el receptor a través de un canal inseguro como Internet, no es una buena idea. Al menos no lo es sin tomar medidas de seguridad adicionales. En próximos artículos intentaremos resolver este problema usando distintos mecanismos criptográficos. Si te gusta la seguridad informática, ¡no te pierdas los próximos artículos!

Si llegado a este punto te quedan dudas pendientes, pregúntame por el [canal de Telegram](https://t.me/lateclaescape), e intentaré ayudarte a resolverla. Gracias por leerme y nos vemos en el siguiente articulo.

Pulso la tecla ESC, dos puntos wq!
