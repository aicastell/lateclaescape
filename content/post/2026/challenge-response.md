---
title: Challenge-Response
date: 2026-07-17
image: /img/posts/challenge-response.webp
categories: [ "cybersecurity", "authentication", "cryptography" ]
tags: [ "challenge_response", "clave_asimétrica", "passwords", "OTP", "FIDO2", "HMAC" ]
draft: false
featured: true
---

# Introducción

El artículo anterior ha explorado las [contraseñas OTP](/post/2026/otp). Con ellas, el proceso de autenticación es relativamente sencillo: tanto el servidor como la aplicación autenticadora generan de forma independiente el mismo código a partir de un secreto compartido y un valor de sincronización. El usuario envía ese código al servidor y este simplemente comprueba si coincide con el que acaba de calcular. Si ambos son iguales, la autenticación es válida.

Es una idea sencilla y elegante que reduce enormemente el impacto del robo de credenciales, ya que cada código solo es válido durante unos pocos segundos.

Sin embargo, sigue existiendo un problema: durante ese breve intervalo de tiempo el código ya no es un secreto. Si un atacante consiguiera interceptarlo antes de que expire, podría reutilizarlo para autenticarse de manera fraudulenta. Es un escenario poco frecuente, pero técnicamente posible.

Esto plantea una pregunta casi inevitable: ¿sería posible demostrar que conocemos un secreto sin llegar a enviarlo nunca al servidor?.

A primera vista parece una contradicción. Si el servidor necesita comprobar que conocemos un secreto, ¿cómo podría hacerlo sin que dicho secreto viajase por la red?.

La respuesta a esta pregunta recibe el nombre de **Challenge-Response**, un mecanismo de autenticación que constituye uno de los pilares de la criptografía moderna y que está presente, de una forma u otra, en muchas de las tecnologías de seguridad que utilizamos a diario. Sigue leyendo porque una vez entiendas cómo funciona, empezarás a reconocerlo prácticamente en todas partes.

# Qué es Challenge-Response

**Challenge-Response** es un protocolo que nace para resolver un problema aparentemente imposible: demostrar que conocemos un secreto sin necesidad de revelarlo.

La idea consiste en sustituir el envío del secreto por una prueba de conocimiento. En lugar de transmitir una contraseña, una clave o cualquier otro dato confidencial al servidor, el cliente demuestra que lo conoce resolviendo un desafío criptográfico que únicamente puede responder correctamente quien posee ese secreto.

Su funcionamiento puede resumirse en tres pasos muy sencillos:

- El servidor genera un valor aleatorio e impredecible y se lo envía al cliente. Ese valor se denomina **challenge** (reto).
- El cliente aplica una operación criptográfica al challenge utilizando el secreto que posee y devuelve el resultado al servidor. Ese resultado es la **response** (respuesta).
- El servidor realiza exactamente la misma operación por su cuenta y compara el resultado obtenido con el que ha recibido. Si ambos coinciden, la autenticación es correcta.

El flujo de autenticación puede representarse de la siguiente manera:

![Challenge-Response protocol](/img/challenge-response-protocol.webp)


Este cambio de enfoque modifica por completo la forma de entender la autenticación. El servidor ya no necesita recibir el secreto para comprobar nuestra identidad. Le basta con verificar que somos capaces de utilizarlo correctamente.

Ese es precisamente el principio sobre el que se construye **Challenge-Response**.

Lo que viaja por la red no es el secreto, sino la respuesta a un desafío diferente en cada autenticación. Como el desafío cambia continuamente, una respuesta obtenida durante una autenticación no sirve para la siguiente. Además, sin conocer el secreto, calcular una respuesta válida resulta computacionalmente inviable.

De esta forma, el servidor puede verificar que el cliente conoce el secreto sin que este tenga que abandonar nunca su dispositivo.

# Implementaciones de Challenge-Response

Existen dos grandes formas de implementar **Challenge-Response**: mediante [criptografía simétrica](/post/2024/criptografia-simetrica) o mediante [criptografía asimétrica](/post/2024/criptografia-asimetrica).

## Implementación con criptografía simétrica

Una de las implementaciones más habituales de **Challenge-Response** utiliza [criptografía simétrica](/post/2024/criptografia-simetrica) mediante **HMAC** (Hash-based Message Authentication Code).

En este modelo, tanto el cliente como el servidor conocen previamente un mismo secreto compartido. La idea es muy sencilla: ambos aplican exactamente la misma función criptográfica sobre las mismas entradas y, como resultado, obtienen exactamente el mismo resultado.

Puedes pensar en **HMAC** como una [función de hash](/post/2024/huellas-digitales-fingerprints) que incorpora una entrada adicional: un secreto criptográfico. Mientras que una función de hash tradicional calcula una huella digital únicamente a partir de un mensaje, **HMAC** la calcula utilizando una entrada que combina el mensaje y el secreto compartido.

Cuando el servidor genera un challenge, lo envía al cliente. Este calcula la respuesta aplicando **HMAC** sobre el challenge y el secreto:

```
response = HMAC(secreto_compartido, challenge)
```

A continuación, envía únicamente la respuesta al servidor.

Como el servidor conoce el mismo secreto y también dispone del challenge que él mismo generó, puede repetir exactamente el mismo cálculo. Si el resultado obtenido coincide con la respuesta recibida, concluye que el cliente conoce el secreto compartido, aunque dicho secreto nunca haya abandonado el dispositivo del cliente.

![Challenge-Response symmetric protocol](/img/challenge-response-symmetric.webp)

Esta implementación es sencilla, muy eficiente y está ampliamente estandarizada. Por ese motivo es habitual encontrarla en sistemas embebidos, dispositivos criptográficos y otros entornos donde la capacidad de cálculo o el consumo energético son factores importantes.

## Implementación con criptografía asimétrica

Una alternativa cada vez más habitual consiste en implementar **Challenge-Response** mediante [criptografía asimétrica](/post/2024/criptografia-asimetrica).

A diferencia del modelo anterior, cliente y servidor ya no comparten un mismo secreto. En su lugar, el cliente genera un par de [claves asimétricas](/post/2024/criptografia-asimetrica): una clave privada, que nunca abandona el dispositivo, y una clave pública, que se comparte con el servidor.

El servidor genera un challenge y se lo envía al cliente. El cliente lo firma digitalmente utilizando su clave privada:

```
response = firma_digital(clave_privada, challenge)
```

A continuación, envía únicamente la respuesta al servidor.

El servidor verifica la respuesta utilizando la clave pública correspondiente. Si la firma es válida, el servidor puede concluir que únicamente quien posee la clave privada ha podido generar esa respuesta, aunque dicha clave nunca haya sido transmitida.

![Challenge-Response asymmetric protocol](/img/challenge-response-asymmetric.webp)

Este enfoque aporta una ventaja muy importante respecto al modelo basado en HMAC: el servidor ya no necesita almacenar ningún secreto del cliente. Incluso si el servidor fuera comprometido, un atacante únicamente obtendría las claves públicas registradas, que por sí solas no permiten suplantar la identidad del usuario.

Gracias a estas ventajas, la criptografía asimétrica se ha convertido en la implementación predominante de **Challenge-Response** en los sistemas de autenticación modernos.

# ¿Dónde se utiliza Challenge-Response?

**Challenge-Response** es un protocolo que está presente en multitud de tecnologías que utilizamos a diario. Lo encontramos en sistemas de autenticación remota, tarjetas inteligentes, módulos TPM, dispositivos criptográficos y muchos otros mecanismos destinados a proteger credenciales.

Cada uno de ellos adapta el protocolo a sus propias necesidades, pero todos comparten la misma idea fundamental: demostrar la posesión de un secreto o de una clave criptográfica sin necesidad de revelarla.

Precisamente por esa versatilidad, **Challenge-Response** se ha convertido en uno de los mecanismos de autenticación más importantes de la criptografía moderna y sirve como base para muchos de los estándares que utilizamos actualmente.

# Conclusiones

**Challenge-Response** representa un cambio de paradigma respecto a los mecanismos clásicos de autenticación. En lugar de demostrar nuestra identidad enviando un secreto al servidor, demostramos que conocemos el secreto resolviendo un desafío criptográfico cuya respuesta únicamente puede calcular quien posee el secreto o la clave privada correspondiente.

Este sencillo principio evita que las credenciales tengan que viajar por la red y constituye uno de los pilares de la autenticación moderna. Comprender cómo funciona permite entender por qué muchos sistemas actuales han abandonado progresivamente el uso exclusivo de contraseñas.

Sin embargo, **Challenge-Response** por sí solo no resuelve todos los problemas. Todavía quedan preguntas importantes por responder. ¿Cómo se registra una nueva credencial? ¿Cómo sabe el servidor qué clave debe utilizar para verificar una autenticación? ¿Qué impide que un atacante nos engañe mediante una página web falsa? ¿Cómo es posible iniciar sesión sin escribir una contraseña?

Responder a todas estas preguntas requiere un protocolo completo capaz de gestionar el registro, la autenticación y la relación de confianza entre el usuario y el servicio.

Ese protocolo existe y se llama **FIDO2**.

En el próximo artículo veremos cómo **FIDO2** toma la idea de **Challenge-Response** y la convierte en uno de los sistemas de autenticación más seguros y revolucionarios de los últimos años. Una vez entiendas su funcionamiento, descubrirás que detrás de un simple botón de "Iniciar sesión" ocurren muchas más cosas de las que imaginabas.

Si te gustan este tipo de artículos sobre seguridad, criptografía y sistemas, puedes seguir el [Canal de Telegram](https://t.me/lateclaescape) para no perderte las próximas entregas de esta serie. Allí publico cada nuevo artículo en cuanto está disponible y comparto noticias, recursos y otras curiosidades relacionadas con los temas que voy investigando.

Muchas gracias por acompañarme hasta aquí. ¡Nos vemos en el próximo articulo!.

Pulso la tecla `ESC:wq!`
