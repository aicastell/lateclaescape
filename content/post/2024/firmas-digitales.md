---
title: Las firmas digitales
date: 2024-03-16
image: "/img/posts/digital-signature.webp"
categories: ["criptografía", "ciberseguridad"]
tags: ["firma digital", "digital signature", "fingerprint", "mitm"]
draft: false
featured: true
---

# Motivación

En este articulo analizo otro concepto fundamental en seguridad informática: las firmas digitales. Este concepto esta muy relacionado con las firmas manuscritas. Así que voy a empezar hablando sobre ellas.

Pero antes de continuar, te recomiendo la lectura de dos artículos publicados anteriormente, que te van a ayudar a entender mejor lo que sigue:

- [Huellas digitales](/post/2024/huellas-digitales-fingerprints)
- [Criptografía asimétrica](/post/2024/criptografia-asimetrica)

## Firmas manuscritas

En el mundo físico, una firma manuscrita es un símbolo reconocible y único, asociado a la identidad de una persona, que permite autenticar la identidad del firmante y verificar la integridad del documento firmado.

Antes de firmar un documento, la persona firmante es requerida para mostrar algún documento oficial para verificar su identidad. Así se autentica la identidad del firmante.

La presencia de una firma manuscrita en un documento indica que la persona que lo ha firmado ha revisado y aceptado su contenido. De esta manera se verifica la integridad del documento firmado.

Una vez que se ha firmado el documento, la firma se considera legalmente vinculante.

## Firmas digitales

Las firmas digitales actúan en el mundo digital de la misma forma que las firmas manuscritas en el mundo físico.

El uso mas común de las firmas digitales es autenticar la identidad del remitente y asegurar la integridad del mensaje durante su transmisión. Pero éste no es su único caso de uso, como veremos antes de concluir este artículo.

Autenticar la identidad del remitente significa poder verificar que el emisor del mensaje es en realidad quien dice ser. Es un proceso crucial en seguridad informática y se utiliza para garantizar la confianza en la procedencia del mensaje recibido.

Garantizar la integridad del mensaje significa garantizar que los datos recibidos no han sido manipulados ni alterados desde el momento en que fueron firmados digitalmente por el emisor hasta el momento en que son verificados por el receptor.

## Generación y verificación

Este esquema resume el proceso completo de generación y verificación de una firma digital:

![digital signature generation verification](/img/digital-signature-generation-verification.webp)

### Generación de la firma digital

Antes de enviar un mensaje, el emisor debe generar su firma digital. Esto se hace utilizando huellas digitales y criptografía asimétrica. Veamos como.

Primero, el emisor genera la huella digital del mensaje M, HE, utilizando una función de hash:

```
HASH(M) = HE
```

Luego, el emisor cifra esta huella digital HE con su clave privada asimétrica.

```
ASYM_ENCRYPT(K_PRI, HE) = DISIGN
```

Al resultado de esta función, DISIGN, se le conoce como **firma digital** del mensaje M. Esta firma digital DISIGN es única para cada mensaje, lo que hace que sea virtualmente imposible para cualquier persona falsificar o modificar la firma sin ser detectada.

El emisor envía un objeto Message compuesto por el propio mensaje M y por su firma digital DISIGN. Representaré al objeto Message de esta manera:

```
Message { "M", "DISIGN" }
```

### Verificación de la firma digital

El receptor recibe el objeto Message y extrae del mismo el mensaje M y su firma digital DISIGN.

A partir del mensaje M calcula su huella digital utilizando la misma función de hash que ha usado el emisor para generarla:

```
HASH(M) = HR
```

La firma digital DISIGN se desencripta usando la clave pública del emisor, obteniendo la huella digital HE original generada por el propio emisor.

```
ASYM_DECRYPT(K_PUB, DISIGN) = HE
```

Por ultimo, el receptor compara HE y HR. Pueden ocurrir dos cosas:

Si HE y HR son distintos, la integridad del mensaje ha sido comprometida, por lo que no podemos confiar en el contenido del mensaje. Hemos detectado un mensaje fraudulento y debemos descartarlo de inmediato.

Si HE y HR son iguales, se da por valida la firma digital. Por tanto, estamos seguros que el mensaje proviene de la fuente esperada y no ha sido modificado en tránsito.

## Ejemplo de generación y verificación

Veamos un ejemplo sencillo fácil de entender por todo el mundo.

Alice y Bob son dos viejos amigos que han superado algunos baches en su amistad. Intentaron comunicarse en secreto usando criptografía simétrica y asimétrica para enviarse mensajes. En ambos escenarios descubrieron que Eva había interceptado sus comunicaciones realizando un ataque MITM. Tras aclarar lo sucedido, han decidido cambiar de estrategia, y utilizarán firmas digitales. Veamos como:

Alice genera un par de claves asimétricas en su ordenador:

- K_ALICE_PUB
- K_ALICE_PRI

Alice envía un mensaje a Bob por Whatsapp, para compartir su clave publica.

### Ejemplo de generación

Un buen día por la mañana, Alice quiere mandarle un mensaje secreto a Bob. Alice genera el mensaje M con este contenido:

```
M = "Mañana tengo una sorpresa para ti"
```

Alice utiliza la función de hash SHA-256 para generar una huella digital del mensaje M:

```
SHA-256("Mañana tengo una sorpresa para ti") = 5f21e65c29b62f30233c1b53bd45c69867321c5fc20319ef9ce324fb4645c98c
```

Alice genera la firma digital, encriptando la huella digital con su propia clave privada (K_ALICE_PRI):

```
ASYM_ENCRYPT(K_ALICE_PRI, "5f21e65c29b62f30233c1b53bd45c69867321c5fc20319ef9ce324fb4645c98c") = "e4g5h6xW"
```

Alice compone este objeto Message:

```
Message {
         "M": "Mañana tengo una sorpresa para ti",
    "DISIGN": "e4g5h6xW"
}
```

Alice envía este objeto Message a Bob.

### Ejemplo de verificación

Bob recibe el objeto Message.

Bob desencripta la firma digital con la clave publica de Alice (K_ALICE_PUB), para obtener el hash original que generó Alice:

```
ASYM_DECRYPT(K_ALICE_PUB, "e4g5h6xW") = 5f21e65c29b62f30233c1b53bd45c69867321c5fc20319ef9ce324fb4645c98c
```

Bob calcula el hash del mensaje M para compararlo con el hash que Alice ha enviado firmado digitalmente:

```
SHA-256("Mañana tengo una sorpresa para ti") = 5f21e65c29b62f30233c1b53bd45c69867321c5fc20319ef9ce324fb4645c98c
```

El hash calculado por Bob coincide con el hash que ha enviado Alice. Por tanto, ahora Bob ya esta seguro que el mensaje es de Alice y que nadie mas lo ha manipulado.

## Problemas de las firmas digitales

Lamentablemente, las firmas digitales por si solas tampoco son seguras. Se pueden atacar usando la técnica del MITM. El atacante malicioso puede interceptar las comunicaciones, alterar la firma digital y el mensaje, y manipular de nuevo las comunicación entre Alice y Bob. Veamos como se hace este ataque:

### Ataque MITM

Alice ha generado un par de claves asimétricas en su ordenador:

- K_ALICE_PUB
- K_ALICE_PRI

Eva, que es una chica muy lista, ha generado en su propio ordenador otro par de claves asimétricas fraudulentas que va a utilizar para el ataque:

- K_MITM_PUB
- K_MITM_PRI

Alice envía un mensaje a Bob por Whatsapp, para compartir su clave publica K_ALICE_PUB. Pero internet es un canal inseguro, y Alice no toma ninguna medida para garantizar que la clave publica enviada es auténtica y pertenece realmente a ella.

El mensaje con la clave publica K_ALICE_PUB es interceptado por Eva. Eva se guarda una copia de la clave K_ALICE_PUB. Y reenvía la clave fraudulenta K_MITM_PUB a Bob. Bob cree erróneamente que K_MITM_PUB es la verdadera clave publica de Alice.

Un buen día por la mañana, Alice quiere mandarle un mensaje secreto a Bob. Alice genera el mensaje M con este contenido:

```
M = "Mañana tengo una sorpresa para ti"
```

Alice utiliza la función de hash SHA-256 para generar una huella digital del mensaje M:

```
SHA-256("Mañana tengo una sorpresa para ti") = 5f21e65c29b62f30233c1b53bd45c69867321c5fc20319ef9ce324fb4645c98c
```

Alice genera la firma digital, encriptando la huella digital con su propia clave privada (K_ALICE_PRI):

```
ASYM_ENCRYPT(K_ALICE_PRI, "5f21e65c29b62f30233c1b53bd45c69867321c5fc20319ef9ce324fb4645c98c") = "e4g5h6xW"
```

Alice compone este objeto Message:

```
Message {
         "M": "Mañana tengo una sorpresa para ti",
    "DISIGN": "e4g5h6xW"
}
```

Alice envía el objeto Message a Bob.

Eva intercepta este objeto Message. Y decide manipularlo, modificando el mensaje original M por un mensaje M' alterado:

```
M' = "Nunca vuelvas a escribirme"
```

Eva utiliza la función de hash SHA-256 para generar la huella digital del mensaje M':

```
SHA-256("Nunca vuelvas a escribirme") = fefbc88ccd9b4c48349b2a67715486674762c28ad925c69eb2c82727883e5f19
```

Eva genera la firma digital del mensaje M' con su propia clave privada (K_MITM_PRI):

```
ASYM_ENCRYPT(K_MITM_PRI, "fefbc88ccd9b4c48349b2a67715486674762c28ad925c69eb2c82727883e5f19") = "N93Gb6G7"
```

Eva recompone el objeto Message:

```
Message {
         "M": "Nunca vuelvas a escribirme",
    "DISIGN": "N93Gb6G7"
}
```

Eva reenvía el objeto Message a Bob.

Bob recibe el objeto Message alterado por Eva.

Lo primero que hace es desencriptar la firma digital con la supuesta clave publica de Alice (K_MITM_PUB), para obtener el hash original que supuestamente generó Alice:

```
ASYM_DECRYPT(K_MITM_PUB, "N93Gb6G7") = fefbc88ccd9b4c48349b2a67715486674762c28ad925c69eb2c82727883e5f19
```

Bob ahora calcula el hash del mensaje M para compararlo con el hash que supuestamente ha enviado Alice firmado digitalmente:

```
SHA-256("Nunca vuelvas a escribirme") = fefbc88ccd9b4c48349b2a67715486674762c28ad925c69eb2c82727883e5f19
```

El hash calculado por Bob coincide con el hash que supuestamente ha enviado Alice firmado con su supuesta clave privada. Por tanto, Bob cree erróneamente que Alice no quiere volver a saber nada de él.

El problema principal es que el receptor (Bob) no tiene manera de saber que la clave publica que recibe del emisor (Alice) es en realidad la suya, y no la de un atacante MITM. En este caso, el atacante se ha apropiado de la personalidad del emisor. Y ni el receptor ni el propio emisor se darán nunca cuenta de dicha situación.

Para resolver este problema necesitaremos hablar sobre certificados digitales firmados por una autoridad certificadora de confianza. Trataré este asunto en el próximo articulo sobre seguridad informática.

### Propiedades

Las firmas digitales tienen muchas propiedades:

- Permiten verificar la identidad del emisor.
- Eliminan la necesidad de firmas manuscritas.
- Eliminan la necesidad de intermediarios para verificar y autenticar a las partes.
- Garantizan la integridad de los datos.
- Proporcionan un mecanismo eficaz para que el emisor no pueda negar su participación en los hechos.
- Cumplen con todos los requisitos regulatorios necesarios para asegurar que los distintos casos de uso sean legalmente vinculantes.

## Casos de uso

Como dije al principio de este articulo, las firmas digitales se pueden usar en otros muchos escenarios diferentes donde se requiere autenticar a la entidad que genera un objeto digital (algo mucho mas genérico que un mensaje) y a su vez garantizar la integridad de dicho objeto digital. Veamos otros casos de uso:

- Transacciones financieras.
- Certificación de software.
- Contratos inteligentes.
- Autores de objetos digitales.
- Sistemas de voto electrónico.
- Certificados digitales.
- Wallets de criptomonedas.

En el ámbito financiero y comercial, las firmas digitales se utilizan para autorizar transacciones electrónicas. Por ejemplo, al realizar una transferencia bancaria online, se requiere una firma digital para autorizar la transacción. Esa firma digital verifica la identidad de la persona que envía los fondos por una parte. Y por otra, garantiza la integridad de la transacción para que nadie mas pueda modificar sus datos durante la transmisión.

En la industria del software, las firmas digitales se utilizan para verificar la autenticidad y la integridad de los programas y archivos descargados. Las empresas y desarrolladores de software firman digitalmente sus aplicaciones y actualizaciones para garantizar que no hayan sido modificadas por terceros malintencionados.

Las firmas digitales también pueden utilizarse para indicar la aprobación o el consentimiento de un individuo o entidad respecto a un acuerdo, contrato u otro documento legal. Al firmar digitalmente un documento, la persona firmante está dando su conformidad con los términos y condiciones del mismo.

Las firmas digitales pueden usarse para autenticar al autor de un objeto digital. Esto es particularmente importante en el caso de compositores musicales, dibujantes, escritores, productores de películas, y creadores de todo tipo de obras de arte, donde es importante identificar al autor y evitar alteraciones de sus creaciones.

Las firmas digitales desempeñan un papel crucial en un sistema electoral electrónico, al proporcionar autenticación del votante e integridad en el voto emitido, evitando que sea alterado durante su transmisión o almacenamiento. Pero también garantizando que el votante no pueda negar su partición en el proceso electoral.

Los certificados digitales y los wallets de criptomonedas los dejaré para tratarlos en próximos artículos. Esto va tomando ritmo, así que, ¡no te despistes o te lo vas a perder!

## Conclusión

Hemos visto como las firmas digitales son una herramienta versátil que se utiliza en una amplísima variedad de contextos diferentes para garantizar la autenticidad y la integridad de documentos y transacciones digitales.

Soy consciente que hoy hemos tratado un concepto técnico bastante complejo de entender, y no es fácil encontrar libros donde se explique con claridad. Repasa el texto tantas veces como sea necesario para su comprensión. Y como te digo siempre, no te quedes con dudas, si algo no lo has entendido, no dudes en formular tus preguntas por el [canal de Telegram](https://t.me/lateclaescape) e intentaré ayudarte a resolverlas. Gracias por leerme y nos vemos en el siguiente articulo.

Pulso la tecla ESC, dos puntos wq!
