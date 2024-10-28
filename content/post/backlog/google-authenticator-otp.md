---
title: Google Authenticator OTP
date: 2024-01-19
image: "/img/posts/la-tecla-esc.jpg"
categories: ["tecnología"]
tags: [ ]
draft: true
featured: true
---


Google Authenticator funciona generando códigos de verificación temporales basados en el tiempo, a través de un método conocido como TOTP (Time-based One-Time Password). Para sincronizar dos dispositivos independientes con el mismo código, ambos deben compartir una clave secreta (un token) generada al configurar la autenticación en la cuenta.

El proceso es el siguiente:

    Clave secreta compartida: Cuando vinculas una cuenta con Google Authenticator, se genera una clave secreta (token) que se comparte con la app a través de un código QR o manualmente.

    Sincronización de tiempo: Tanto el servidor (como el de Google) como el dispositivo móvil están sincronizados mediante una fuente de tiempo estándar (generalmente con una tolerancia de unos pocos minutos).

    Generación de códigos: Ambos (el servidor y la app) utilizan la clave secreta junto con la hora actual para generar un hash (generalmente SHA-1), y de ese hash, se extrae un código numérico de 6 dígitos.

    Verificación: Cuando ingresas el código en el servidor, este calcula el código actual para esa clave y hora, y lo compara con el que has ingresado. Si coinciden (con una pequeña tolerancia en el tiempo), el acceso es concedido.

Este mecanismo asegura que, aunque los dispositivos no estén conectados entre sí, puedan generar los mismos códigos simultáneamente mientras compartan la misma clave secreta y estén sincronizados temporalmente.
Tú dijiste:
entonces si cambio la hora de uno de los dispositivos a proposito, dejaría de funcionar?
ChatGPT Plus
ChatGPT

Sí, si cambias la hora de uno de los dispositivos de forma significativa, los códigos generados dejarán de coincidir con los del servidor, y Google Authenticator dejará de funcionar correctamente en ese dispositivo. Esto se debe a que el sistema TOTP (Time-based One-Time Password) utiliza la hora actual, además de la clave secreta, para generar el código.

Si el reloj del dispositivo está desincronizado, el código generado será incorrecto porque el servidor también usa la hora para calcular el código. Generalmente, hay una pequeña tolerancia de tiempo (de unos pocos minutos), pero un cambio mayor en la hora puede hacer que los códigos no coincidan y, por lo tanto, el inicio de sesión fallará.

Para evitar este problema, puedes asegurarte de que el reloj de tus dispositivos esté configurado correctamente, preferiblemente sincronizándolos automáticamente con la hora de Internet.



