---
title: Wireguard
date: 2024-04-13
image: /img/posts/wireguard.webp
tags: [ "VPN", "WireGuard" ]
categories: [ "redes" ]
draft: false
featured: true
---

# Motivación

Las tecnologías mas populares de VPN como OpenVPN o IPsec son a menudo complicadas de instalar y administrar. Son lentas, y pueden utilizar cifrados obsoletos. Además, tienen un código complejo, con hasta 400.000 líneas de código, lo que dificulta mucho la detección de errores.

En este articulo hablo sobre [WireGuard](https://www.wireguard.com/), un protocolo revolucionario que rompe con todas las convenciones establecidas por sus predecesores y que en pocos años se ha ganado la atención y el reconocimiento de la comunidad de ciberseguridad.

Acompáñame en la lectura de este articulo, porque hoy vas a descubrir el futuro de las redes de comunicaciones seguras.

## Diseño

A continuación voy a dar un repaso general a varios aspectos del diseño de WireGuard, incluyendo su consumo de recursos, velocidad, seguridad y capacidad de itinerancia entre redes.

### Recursos

Mientras que las tecnologías mas populares de VPN como OpenVPN o IPsec consumen una cantidad significativa de recursos del sistema, WireGuard está diseñado para ser liviano y eficiente en términos de consumo de CPU y uso de memoria.

Esto minimiza el consumo de energía y la carga del procesador, lo que mejora el rendimiento en dispositivos móviles y aumenta la vida útil de las baterías.

Estas características hacen que Wireguard sea ideal para dispositivos con recursos limitados como routers domésticos, dispositivos IoT, y sistemas embedded en general.

### Velocidad

WireGuard está diseñado para ser más rápido y eficiente que sus predecesores.

Utiliza un diseño simplificado que reduce la sobrecarga de procesamiento, reduce el tiempo de conexión, mejora los tiempos de latencia, reduciendo la carga general del sistema.

Estas características hacen que Wireguard sea ideal para aplicaciones que requieren transferencias de datos intensivas, como streaming de vídeo o juegos en línea.

### Seguridad

WireGuard ha sido diseñado desde cero con un enfoque basado en la seguridad en todas las etapas de su desarrollo.

Utiliza algoritmos criptográficos modernos y seguros para garantizar la confidencialidad, la integridad y la autenticidad de los datos transmitidos a través de la VPN.

Ha sido sometido a múltiples auditorías de seguridad independientes, lo que ha ayudado a identificar y corregir posibles vulnerabilidades.

El equipo de desarrollo está comprometido con la mejora continua y la corrección proactiva de problemas de seguridad, lo que garantiza que el protocolo se mantenga seguro y resistente a medida que evolucionan las amenazas.

### Roaming

Wireguard está diseñado para admitir la movilidad y el roaming de manera efectiva, lo que significa que las conexiones VPN se pueden mantener activas incluso en entornos de red inestables, donde los dispositivos cambian de red continuamente.

## Implementación

WireGuard empezó a desarrollarse en 2015 por el joven [Jason A. Donenfeld](https://www.businessinsider.es/logro-captar-atencion-hacker-seguridad-vpn-793259) cuando apenas tenia 26 años.

Aunque el protocolo se hizo público en 2016, hasta Junio de 2018, los desarrolladores de WireGuard recomendaban tratar el código y el protocolo como experimentales.

WireGuard esta implementado como un módulo del Linux kernel, en lenguaje C. Algunas herramientas adicionales de espacio de usuario se han desarrollado en Go.

En Diciembre de 2019, [David Miller](https://en.wikipedia.org/wiki/David_S._Miller), responsable principal del stack de networking de Linux, aceptó los parches de WireGuard en la rama *net-next*. Esta rama del kernel se utiliza para integrar y probar características nuevas, mejoras y parches relacionados con el subsistema de networking, antes de incorporarlos a la rama principal.

En Enero de 2020, [Linus Torvalds](https://es.wikipedia.org/wiki/Linus_Torvalds) decidió fusionar esta rama *net-next* en la rama principal del Linux. Lo cual indica que el código fuente está bien escrito, bien probado y cumple con los altísimos estándares de calidad de Linux.

Todos los [repositorios de código fuente](https://www.wireguard.com/repositories/) relacionados con WireGuard son open source. Esto significa que su código fuente está disponible para su revisión pública, lo que permite una mayor transparencia y confianza en su seguridad.

La implementación de WireGuard apenas tiene 4.000 lineas de código, lo que supone un 1% del código de OpenVPN o IPsec. Al ser mucho mas fácil de entender, se facilitan las auditorías de seguridad y la identificación de posibles problemas.

El código fuente es muy versátil y hay implementaciones para una amplísima variedad de sistemas operativos, incluidos Linux, Windows, macOS, Android e iOS.

## Funcionamiento

WireGuard es un túnel de red seguro que opera en la capa de red del modelo OSI (capa 3) y funciona sobre el protocolo de transporte UDP del modelo OSI (capa 4).

Se implementa como una interfaz de red virtual del kernel, lo que le permite integrarse estrechamente con el sistema operativo y ofrecer un rendimiento óptimo.

A diferencia de otros protocolos VPN que utilizan certificados digitales X.509, WireGuard adopta un enfoque más simple y eficiente. En lugar de certificados digitales, WireGuard utiliza [criptografía asimétrica](/posts/criptografia-asimetrica) para funcionar. En particular, emplea el algoritmo Elliptic Curve Diffie-Hellman (ECDH) basado en Curve25519 para generar el par de claves asimétricas (pública y privada) que necesita cada dispositivo que va a utilizar el túnel de comunicación seguro con el servidor. Esto simplifica el proceso de establecimiento de la conexión y reduce la carga administrativa asociada con la gestión de certificados digitales.

Una vez configurada la conexión, WireGuard gestiona automáticamente el cifrado y la autenticación de la comunicación entre cada dispositivo y el servidor, utilizando las claves asimétricas establecidas previamente. Este enfoque garantiza un proceso de configuración simple y una comunicación segura, sin comprometer la eficiencia ni la seguridad. Además, la simplicidad y la transparencia del protocolo hacen que sea más fácil para los administradores de sistemas y los usuarios entender y gestionar la seguridad de sus conexiones VPN.

Para los lectores que necesitéis saber mas, os dejo el enlace al [whitepaper](https://www.wireguard.com/papers/wireguard.pdf) donde podéis encontrar todos los detalles técnicos.

# Despedida

WireGuard es un protocolo VPN moderno que ofrece una combinación única de simplicidad, rendimiento y seguridad. Su adopción continúa creciendo a medida que más usuarios y organizaciones reconocen sus ventajas y beneficios en comparación con otras soluciones VPN tradicionales.

En próximos articulos explicaré como instalar un [servidor de WireGuard](/posts/wireguard-server) en un servidor Linux, como instalar un [cliente de WireGuard en Android](/posts/wireguard-client-android), y como instalar un [cliente de WireGuard en Linux](/posts/wireguard-client-linux) para que puedas navegar de forma segura. Si te interesa este tema, no te pierdas lo que esta por venir.

Espero que este artículo haya captado tu atención sobre WireGuard. Merece mucho la pena. Si quieres plantear alguna duda, o simplemente si quieres mandar un saludo, te invito a unirte al [canal de Telegram](https://t.me/lateclaescape). ¡Nos vemos muy pronto!.

Pulso la tecla ESC, dos puntos wq!
