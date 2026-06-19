---
title: Múltiple factor de autenticación
date: 2026-06-19
image: /img/posts/mfa.webp
categories: [ "cybersecurity", "authentication" ]
tags: [ "MFA", "2FA", "passwords" ]
draft: false
featured: true
---

# Introducción

Las contraseñas llevan décadas siendo la principal barrera de protección de nuestros sistemas. Las utilizamos para acceder al correo electrónico, a la banca online, a las redes sociales, a los servicios en la nube y prácticamente a cualquier recurso digital que forme parte de nuestra vida cotidiana.

Durante mucho tiempo parecieron una solución razonable. Al fin y al cabo, si una contraseña es secreta, únicamente debería poder utilizarla su propietario legítimo. Sin embargo, la realidad es bastante más compleja.

A medida que nuestra vida digital ha ido creciendo, también lo ha hecho el número de servicios que utilizamos y, con él, la cantidad de credenciales que debemos gestionar. Hoy en día dependemos de las contraseñas para proteger una enorme cantidad de información.

Pero, como suele ocurrir en seguridad informática, ninguna solución es perfecta. Las contraseñas presentan ciertas limitaciones que resultan difíciles de ignorar y que conviene comprender antes de confiar plenamente en ellas.

En este artículo analizaremos cuáles son esas limitaciones y qué mecanismos han surgido para reducir su impacto.

Si te interesa la ciberseguridad o simplemente quieres aprender a proteger mejor tus credenciales, sigue leyendo porque este es uno de los conceptos más importantes de la seguridad informática moderna.

# Contraseñas comprometidas

Las contraseñas funcionan muy bien como primera línea de defensa para evitar que personas no autorizadas accedan a nuestros servicios. Sin embargo, tienen un problema difícil de resolver: son información. Y la información es fácil de copiar.

Una contraseña puede verse comprometida de innumerables formas. Alguien puede observarla mientras la introduces en un teclado, encontrarla anotada en un papel que termina en la basura, verla escrita en un post-it pegado al monitor o descubrirla en un dispositivo de almacenamiento perdido u olvidado.

En otros casos, el robo puede producirse de forma completamente transparente para el usuario. Un malware, un keylogger o una red insegura podrían capturar las credenciales sin dejar ninguna evidencia visible.

![MFA hacker robando passwords](/img/mfa-hacker-robando-passwords.webp)

Los ataques tampoco tienen por qué ser técnicos. El phishing y la ingeniería social siguen siendo algunas de las técnicas más efectivas para obtener contraseñas legítimas aprovechando el engaño y la confianza de las personas.

Por si fuera poco, muchas credenciales terminan expuestas como consecuencia de filtraciones de datos en servicios de terceros. Cuando una contraseña reutilizada aparece en una brecha de seguridad, los atacantes suelen probarla automáticamente en decenas de plataformas diferentes.

A todo ello hay que añadir errores de configuración, copias de seguridad mal protegidas, sincronizaciones inseguras entre dispositivos o incluso el intercambio involuntario de credenciales con otras personas.

Llegados a este punto, da igual lo compleja que sea una contraseña. Si alguien consigue obtenerla por cualquier medio, el problema ya no es la fortaleza de la clave, sino que ha dejado de ser secreta.

Y cuando una contraseña deja de ser secreta, el sistema no tiene forma de distinguir entre su usuario legítimo y quien la ha obtenido de manera fraudulenta. Ambos van a disfrutar exactamente de los mismos privilegios.

# Multifactor de autenticación

Ante este problema surgieron los sistemas de autenticación multifactor (MFA).

La idea es bien sencilla: si una contraseña puede ser copiada, robada o reutilizada, quizás no sea buena idea confiar toda la seguridad en un único secreto.

En lugar de depender de una sola contraseña, la autenticación multifactor combina distintos tipos de evidencias para demostrar la identidad de un usuario:

- Algo que sabes: una contraseña o un PIN.
- Algo que tienes: una llave física.
- Algo que eres: una característica biométrica.

Cuantos más factores independientes intervienen en el proceso de autenticación, más difícil resulta para un atacante suplantar la identidad de la persona legítima. Y esa pequeña diferencia cambia por completo las reglas del juego.

![MFA hacker aburrido](/img/mfa-hacker-aburrido.webp)

Un atacante podría conseguir la contraseña mediante phishing, malware, ingeniería social o una filtración de datos. Sin embargo, eso ya no garantiza el acceso si existen otros factores de autenticación que también deban ser verificados.

La contraseña sigue siendo importante, pero deja de ser el único elemento responsable de proteger una cuenta. En otras palabras, la seguridad deja de apoyarse en una única evidencia y pasa a basarse en varias pruebas independientes de identidad.

# Mecanismos habituales

La autenticación multifactor no depende de una tecnología concreta. Existen diferentes mecanismos para implementar el factor adicional de seguridad, cada uno con sus propias ventajas e inconvenientes.

## SMS

Durante muchos años, el envío de códigos mediante SMS ha sido el sistema de autenticación multifactor más extendido.

El funcionamiento es sencillo: después de introducir la contraseña, el servicio envía un código temporal al teléfono móvil del usuario. Dicho código debe introducirse para completar el proceso de autenticación.

Su principal ventaja es la simplicidad. Casi cualquier persona dispone de un teléfono móvil capaz de recibir mensajes SMS, por lo que no requiere instalar aplicaciones ni adquirir hardware adicional.

Sin embargo, también presenta algunas limitaciones importantes. Los mensajes pueden sufrir retrasos, dependen de la cobertura móvil y existen técnicas como el fraude por duplicado de SIM (SIM Swapping) que permiten a un atacante obtener acceso a los códigos de autenticación en determinadas circunstancias.

Por este motivo, aunque sigue siendo mejor que utilizar únicamente una contraseña, actualmente se considera una de las opciones menos seguras para implementar autenticación multifactor.

## Aplicaciones autenticadoras

Una alternativa cada vez más popular consiste en utilizar aplicaciones capaces de generar códigos temporales directamente en el teléfono móvil.

Entre las más conocidas se encuentran:

- [Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&pcampaignid=web_share)
- [Aegis](https://getaegis.app/)
- [Authy](https://www.authy.com/)

En lugar de recibir un SMS, la aplicación genera automáticamente un nuevo código cada pocos segundos. Como el código se calcula localmente en el dispositivo, no depende de la red móvil ni del envío de mensajes.

Este enfoque es más seguro que el SMS y ofrece una experiencia de uso muy sencilla para la mayoría de usuarios.

Su principal inconveniente es que el teléfono pasa a convertirse en una pieza crítica del sistema de autenticación. Por ello resulta especialmente importante disponer de copias de seguridad o mecanismos de recuperación adecuados.

## Correo electrónico

Muchos servicios utilizan el correo electrónico como segundo factor de autenticación.

Cuando el usuario intenta iniciar sesión, el servicio envía un código temporal o un enlace de confirmación a una dirección de correo previamente registrada.

Se trata de una solución cómoda y fácil de implementar, pero presenta una limitación evidente: si la cuenta de correo electrónico se ve comprometida, el atacante podría obtener también acceso a los mecanismos de recuperación y autenticación asociados a otros servicios.

Por este motivo suele considerarse una opción aceptable para cuentas de bajo riesgo, pero no recomendable para proteger servicios especialmente sensibles.

## Llaves físicas

La alternativa más robusta consiste en utilizar dispositivos hardware diseñados específicamente para participar en procesos de autenticación.

A diferencia de los SMS o de las aplicaciones móviles, estos dispositivos incorporan mecanismos criptográficos propios y requieren la posesión física del hardware para completar la autenticación.

Su principal ventaja es que resultan extremadamente difíciles de copiar y ofrecen una gran resistencia frente a ataques de phishing y robo de credenciales.

Entre las llaves de seguridad más populares se encuentran las Yubikey, una familia de dispositivos capaces de implementar diferentes tecnologías de autenticación y protección criptográfica.

# Conclusión

Durante décadas hemos confiado buena parte de nuestra seguridad digital a las contraseñas. Han demostrado ser una solución sencilla, económica y razonablemente eficaz. Sin embargo, presentan una debilidad difícil de evitar: son información. Y la información puede copiarse.

La autenticación multifactor surge precisamente para reducir la dependencia de un único secreto. En lugar de confiar toda la seguridad de una cuenta a una contraseña, distribuye la responsabilidad entre varios factores independientes. De esta forma, comprometer una credencial deja de ser suficiente para acceder a un sistema.

No se trata de una solución perfecta. Ningún mecanismo de seguridad lo es. Tampoco elimina la necesidad de utilizar contraseñas robustas, mantener los sistemas actualizados o actuar con sentido común.

Sin embargo, pocas medidas ofrecen una mejora tan significativa de la seguridad con un impacto tan reducido en la experiencia de uso.

Por este motivo, la autenticación multifactor se ha convertido en una de las medidas de seguridad más recomendadas por administradores de sistemas, expertos en seguridad y organismos especializados de todo el mundo. Después de analizar los problemas que resuelve, es una recomendación difícil de discutir.

Si todavía no utilizas un segundo factor de autenticación en tus cuentas más importantes, te animo a activarlo. Probablemente sea una de las mejoras de seguridad más sencillas y efectivas que puedes implementar desde ya mismo.

En el próximo artículo nos adentraremos en el mundo de las llaves de seguridad hardware utilizando como ejemplo una de las más conocidas: la YubiKey. Veremos qué es exactamente este dispositivo, qué tecnologías incorpora, qué problemas intenta resolver y por qué se ha convertido en una herramienta habitual dentro de la infraestructura de seguridad de administradores de sistemas, desarrolladores y profesionales del sector.

Si te ha gustado el artículo, no olvides suscribirte al [Canal de Telegram](https://t.me/lateclaescape) para ser el primero en enterarte de las próximas novedades.

Muchas gracias por acompañarme hasta aquí y, ¡nos vemos en el próximo articulo!.

Pulso la tecla `ESC:wq!`
