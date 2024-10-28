---
title: Las huellas digitales
date: 2024-03-10
image: /img/posts/huellas-digitales.webp
categories: ["criptografía"]
tags: ["hash", "fingerprint", "huella digital", "mitm"]
draft: false
featured: true
---

# Motivación

Este articulo explica las huellas digitales, un concepto fundamental en seguridad informática.

Las huellas digitales actúan con los objetos digitales de la misma forma que las huellas dactilares con las personas. Voy a empezar definiendo con claridad que es eso de un objeto digital.

## Objetos digitales

Son objetos digitales los archivos de texto, las imágenes, los vídeos, los documentos electrónicos, el software, las bases de datos, los mensajes, las contraseñas, etc.

En general, un **objeto digital** es cualquier objeto que se pueda crear, almacenar, copiar y procesar utilizando un sistema digital como un ordenador, un portátil, un smartphone o cualquier otro dispositivo electrónico que se te ocurra.

Los objetos digitales son intangibles, lo que significa que no tienen una existencia física como pueda ser un libro o una fotografía impresa. Solamente existen en forma de datos electrónicos almacenados en dispositivos electrónicos.

## Huellas digitales

La **huella digital** (también conocida como **digital fingerprint**) de un objeto digital, es un identificador único que permite identificar al objeto digital entre todos los objetos digitales que existen en el universo digital.

Dos objetos digitales exactamente iguales tendrán la misma huella digital. Sin embargo, si alguien altera un solo bit del objeto digital, la huella digital resultante será completamente distinta.

## Las funciones de hash

La huella digital de un objeto digital se obtiene al aplicar sobre dicho objeto una función matemática conocida como **función de hash**. Las funciones de hash toman como **entrada** un objeto digital, aplican una serie de operaciones matemáticas sobre dicho objeto, y producen como **salida** un numero finito y siempre del mismo tamaño, conocido como su huella digital.

Existen multitud de funciones de hash. Todas ellas pueden agruparse en estas familias:

- MD (Message Digest)
- RIPEMD (RACE Integrity Primitives Evaluation Message Digest)
- HAVAL (HAsh of VAriable Length)
- HMAC (Hash-based Message Authentication Code)
- SHA (Secure Hash Algorithm)

Veamos un ejemplo para que entiendas como se comporta una función de hash. Tomamos la cadena de texto "Hola Mundo" como objeto digital de entrada.

### SHA-256

Elegimos como función de hash la SHA-256, perteneciente a la familia SHA (Secure Hash Algorithm). Aplicaremos la función SHA-256 sobre el objeto digital de entrada. Para hacerlo, usaremos la herramienta "openssl" disponible en la linea de comandos de Linux, de la siguiente manera:

```
$ echo -n "Hola Mundo" | openssl sha256
c3a4a2e49d91f2177113a9adfcb9ef9af9679dc4557a0a3a4602e1bd39a6f481
```

Como ves, la función SHA-256 genera como salida un numero de 64 símbolos hexadecimales. Como aprendiste [en este articulo](/posts/sistemas-de-codificacion), cada símbolo hexadecimal se puede codificar con 4 bits. Por tanto, 64 símbolos hexadecimales cada uno de 4 bits, hacen un total de 256 bits. Ese numero de 256 bits es la huella digital generada por la función de hash SHA-256 para la cadena de texto "Hola Mundo".

Ahora manipula el objeto digital de entrada "Hola Mundo". Por ejemplo, cambia la 'a' por una 'x'. Y recalcula su huella digital:

```
$ echo -n "Holx Mundo" | openssl sha256
5963b69ffab9cf6fb716fb51833ee2b7b8fe04d036ff9fa8e6639462ca3e324f
```

Fíjate que la huella digital generada es totalmente distinta.

Si aplicas de nuevo la función de hash SHA-256 sobre estos mismos objetos digitales de entrada, siempre obtendrás como resultado la misma huella digital. Haz tu mismo la prueba utilizando [esta herramienta online](https://www.tools4noobs.com/online_tools/hash/) para calcular huellas digitales.

En conclusión, para un mismo objeto digital de entrada, siempre se genera la misma huella digital. Pero si varías un solo bit del objeto digital de entrada, su huella digital será totalmente diferente.

### MD5

Ahora elegimos MD5, una función de hash diferente, perteneciente a la familia MD (Message Digest). Aplicamos la función MD5 sobre el mismo objeto digital de entrada:

```
$ echo -n "Hola Mundo" | openssl md5
d501194c987486789bb01b50dc1a0adb
```

Observa como la huella digital generada por la función de hash MD5 es totalmente distinta a la huella digital generada por la función de hash SHA-256. En este caso, la función de hash MD5 genera como salida un número de 32 símbolos hexadecimales. Lo que significa que la huella digital generada tiene una longitud del 128 bits.

De nuevo, si manipulas el objeto digital de entrada cambiando la 'a' por una 'x', obtendrás una huella digital totalmente distinta:

```
$ echo -n "Holx Mundo" | openssl md5
7db579f9b8a88cf23f0f5fd9ca4dbbd1
```

Aunque cada función de hash genere una huella digital con un formato diferente, sus propiedades se mantienen. Si repites tu mismo la prueba usando la función de hash MD5 sobre el mismo objeto digital usado en este ejemplo, con independencia de la aplicación que utilices, y con independencia del sistema operativo donde realices la prueba (Linux, MacOS, Android, iOS, o Windows), siempre obtendrás las misma huella digital.

## Propiedad unidireccional

Las funciones de hash son extremadamente rápidas calculando la huella digital del objeto digital de entrada. Sin embargo, las matemáticas subyacentes garantizan que no se pueda obtener el objeto digital de entrada a partir de su huella digital. Por tanto, las funciones de hash son unidireccionales.

Si eres un lector incrédulo que cuestiona la capacidad de las matemáticas para resolver este problema, vamos a poner a prueba las matemáticas.

Imagina que el objeto digital de entrada es un numero entero cualquiera, por ejemplo el 4567. Y que la función de hash SUMADIG, genera la huella digital sumando todos los dígitos del número entero de entrada. Por ejemplo, SUMADIG(4567) = 4+5+6+7 = 22.

Si te doy su huella digital (22), y te pido el número entero de entrada cuyos dígitos sumen 22, me vas a decir que hay muchos, como el 994, el 7771 o el 234562. No es posible dar una respuesta exacta a este problema. La función SUMADIG está actuando de manera unidireccional e irreversible.

Obviamente este es un ejemplo muy sencillo para que entiendas el mecanismo unidireccional. La realidad es mucho mas complicada. Las funciones de hash como SHA-256 o MD5 se diseñan específicamente para resistir ataques maliciosos y proporcionar una seguridad robusta en diversas aplicaciones.

## Ataque por fuerza bruta

Un temible hacker podría aprovechar sus recursos computacionales para calcular la huella digital de millones de objetos digitales generados al azar. Si consiguen generar una huella digital con el mismo valor que la huella atacada, habrán descubierto el objeto digital de entrada. Y se sentirán unos hacker poderosos. Esta técnica es conocida como **ataque por fuerza bruta**.

Sin embargo, atacar una función de hash SHA-256 por fuerza bruta tiene un coste computacional descomunal. Ya sabemos que SHA-256 genera huellas digitales de 256 bits. Esto significa que en el espectro de SHA-256 hay 2 ^ 256 (2 elevado a 256) posibles huellas digitales. Si hacemos el cálculo, nos da este número enorme:

```
115792089237316195423570985008687907853269984665640564039457584007913129639936
```

Este número es extraordinariamente grande. Tan grande que se puede comparar con el número total de átomos estimados en el Universo observable. Se estima que hay aproximadamente 10 ^ 80 (10 elevado a 80) átomos en el Universo observable:

```
100000000000000000000000000000000000000000000000000000000000000000000000000000000
```

Estamos hablando de dos números que tienen aproximadamente el mismo orden de magnitud. Una auténtica barbaridad.

Por tanto, aplicar una función de hash sobre objetos digitales generados de forma aleatoria, en busca de uno que coincida con el hash atacado sería algo prácticamente imposible debido a la enorme capacidad computacional requerida.

## Casos de uso

Las huellas digitales tienen muchas aplicaciones prácticas en nuestro día a día. Expongo algunos casos de uso habituales:

- Integridad de archivos
- Seguridad de contraseñas
- Identificación biométrica
- Documentos oficiales
- Firmas digitales

Puedes generar y almacenar la huella digital de tus archivos importantes. Cuando necesites verificar su integridad, recalculas la huella digital y la comparas con la huella digital almacenada.

En lugar de almacenar contraseñas en una base de datos, puedes almacenar sus huellas digitales asociadas. El usuario que intenta logear con tu sistema te va a enviar su contraseña. Tu calculas la huella digital de la contraseña recibida y la comparas con la huella digital que tienes almacenada en tu base de datos.

A partir de la firma dactilar, de un escáner de retina o del iris, se puede obtener una huella digital que permita identificar a una persona. Esto es muy común en sistemas de seguridad, donde puedes utilizar esa información para desbloquear teléfonos, laptops, ordenadores, smartwatch, etc. O también para controlar el acceso a edificios, oficinas, o aplicaciones de software.

Algunos países incorporan huellas digitales en pasaportes y documentos de identidad para fortalecer la autenticidad y prevenir la falsificación.

Las firmas digitales son un mecanismo de seguridad criptográfica que combina las huellas digital con la [criptografía asimétrica](/posts/criptografia-asimetrica). Mucha gente confunde las firmas digitales con las huellas digitales, pero son cosas totalmente diferentes. En el próximo articulo sobre criptografía trataré específicamente las [firmas digitales](/posts/firmas-digitales). ¡No te lo pierdas!.

## Despedida

Espero haberte aclarado dudas sobre las huellas digitales. Son un mecanismo muy útil y es importante que entiendas como funciona para que construyas una base sólida con la que puedas entender artículos posteriores.

Si tienes alguna duda, si consideras que falta información, o incluso si te ha parecido aburrido y no te gusta este contenido, te animo a compartir tus ideas en el [canal de Telegram](https://t.me/lateclaescape). No me enrollo mas. ¡Nos vemos en el siguiente articulo!

Pulso la tecla ESC, dos puntos wq!
