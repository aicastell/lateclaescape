---
title: OPNsense
date: 2026-03-07
image: /img/posts/opnsense.webp
categories: [ "redes", "cybersecurity", "self_hosting" ]
tags: [ "VPN", "OPNsense", "router", "homelab", "networking" ]
draft: false
featured: true
---

# Motivación

Los routers domésticos están pensados para ser baratos y fáciles de usar, algo suficiente para la mayoría de usuarios.

Sin embargo, cuando empiezas a montar un *homelab* y quieres más control sobre tu red (segmentación, seguridad o servicios propios) sus limitaciones se hacen evidentes: firmware cerrado, pocas opciones de configuración, actualizaciones escasas y poca visibilidad del tráfico.

En ese punto en el que la red deja de ser "el WiFi de casa" y pasa a ser la infraestructura de comunicaciones de tu laboratorio, llegas a la misma conclusión: necesitas un router de verdad.

Aquí es donde entra en juego [OPNsense](https://opnsense.org/), una de las plataformas open-source de firewall y routing más potentes y accesibles que existen hoy en día. En este artículo veremos qué es, por qué encaja tan bien en un *homelab* y qué puedes esperar si decides montar tu propio router DIY

# Qué es OPNsense

OPNsense es un sistema operativo especializado en firewall y routing, basado en [FreeBSD](https://www.freebsd.org/), diseñado para convertir un equipo x86 en un router profesional.

En lugar de utilizar el firmware limitado de un router doméstico, instalas un sistema operativo de red completo, con todas las herramientas necesarias para gestionar el tráfico, aplicar políticas de seguridad y ofrecer servicios básicos de infraestructura de red.

El proyecto nació en 2015 como un fork de [pfSense](https://www.pfsense.org/), con el objetivo de ofrecer una plataforma con:

- desarrollo totalmente abierto
- actualizaciones frecuentes
- una interfaz moderna y fácil de administrar

Con el tiempo se ha convertido en una solución muy popular tanto en *homelabs* avanzados como en entornos profesionales, especialmente en pequeñas empresas, laboratorios de seguridad y entornos educativos donde se necesita un firewall potente y flexible.

## Desarrollo totalmente abierto

El desarrollo de OPNsense se realiza de forma pública en [GitHub](https://github.com/opnsense) y sigue una filosofía clara de software libre y transparente.

Esto significa que cualquier persona puede:

- revisar el código fuente
- auditar el funcionamiento del sistema
- proponer mejoras o correcciones
- contribuir al desarrollo del proyecto

Para un componente tan crítico como el router de tu red, esta transparencia es especialmente valiosa. Permite confiar en el software que gestiona todo el tráfico de la red y evita depender de firmware cerrado sobre el que no tienes visibilidad ni control.

## Actualizaciones frecuentes

OPNsense sigue un ciclo de desarrollo activo. Publica dos versiones mayores al año y actualizaciones menores con bastante frecuencia, que incluyen parches de seguridad, correcciones de errores y mejoras en el sistema.

Estas actualizaciones también incorporan mejoras en el sistema base y en los distintos componentes que utiliza el firewall.

En comparación, muchos routers domésticos reciben pocas actualizaciones a lo largo de su vida útil, y en muchos casos dejan de recibir soporte después de unos pocos años, lo que puede acabar suponiendo un riesgo de seguridad para la red.

## Interfaz moderna

Uno de los puntos fuertes de OPNsense es su interfaz web clara y bien organizada. Desde el panel de administración puedes gestionar prácticamente todos los aspectos del sistema:

- interfaces de red
- reglas de firewall
- NAT
- VPN
- VLAN
- DNS
- DHCP
- IDS/IPS
- monitorización del tráfico
- filtrado de anuncios

Todas estas funciones se configuran desde una única interfaz centralizada, lo que simplifica mucho la administración del sistema.

Esto reduce enormemente la complejidad frente a configurar manualmente estos servicios en un sistema Unix tradicional, permitiendo acceder a funcionalidades avanzadas de red sin tener que gestionar directamente los archivos de configuración del sistema.

# OPNsense en un *homelab*

La mayoría de routers domésticos ofrecen un conjunto muy limitado de funciones: conexión a Internet, NAT, Wi-Fi y poco más. Para un uso básico es suficiente, pero cuando empiezas a construir un *homelab* esas capacidades se quedan rápidamente cortas.

OPNsense permite ir mucho más allá. Con él puedes construir una red doméstica con una arquitectura mucho más cercana a la que encontrarías en un entorno profesional, con mayor control, seguridad y flexibilidad.

Esto no solo mejora la gestión de tu red, sino que también abre muchas posibilidades para aprender, experimentar y ampliar tu laboratorio con el tiempo.

Algunas de las ventajas más interesantes de usar OPNsense en un *homelab* son:

- Control total de la red
- Segmentación mediante VLAN
- Soporte integrado para VPN
- Plugins y servicios adicionales que amplían sus capacidades

## Control total de la red

En una instalación típica, OPNsense se sitúa entre tu red doméstica y la red de tu proveedor de Internet:

```
Internet → WAN (OPNsense) → LAN / VLAN → tu red
```

Esto convierte al router en el punto central por el que pasa todo el tráfico de la red, permitiendo inspeccionarlo, filtrarlo y aplicar políticas de seguridad o de gestión del tráfico.

Desde OPNsense puedes definir con precisión cómo se comporta tu red. Por ejemplo:

- Bloquear dispositivos IoT para que no accedan a otros equipos
- Permitir acceso a un servidor solo desde determinadas redes
- Priorizar tráfico sensible a la latencia, como videollamadas
- Limitar el ancho de banda de ciertos dispositivos

Todas estas reglas se gestionan desde una interfaz web bastante intuitiva, acompañada de estadísticas y registros que permiten entender qué está ocurriendo en la red en cada momento.

## Segmentación con VLANs

Una de las ventajas más útiles en un *homelab* es segmentar la red en distintas VLANs, lo que mejora seguridad y organización al separar dispositivos según su función.

| VLAN | Uso |
|------|-----|
| LAN | ordenadores personales |
| IoT | domótica, cámaras, televisores |
| Guest | red para invitados |
| Servers | NAS, proxmox |
| Lab | pruebas y experimentos |

Con OPNsense puedes crear estas VLANs y definir reglas de firewall entre ellas, por ejemplo aislando IoT, limitando la red de invitados a Internet o controlando el acceso a los servidores. Este tipo de arquitectura es habitual en redes profesionales, mientras que en muchos routers domésticos todos los dispositivos comparten la misma red.

## VPN integrada

OPNsense incluye soporte integrado para varios tipos de VPN:

- [WireGuard](/post/2024/wireguard)
- OpenVPN
- IPsec

Esto permite implementar varios escenarios muy útiles en un *homelab*, por ejemplo:

- acceder a tu red doméstica desde Internet
- conectarte de forma segura cuando viajas
- conectar tu casa con un servidor en la nube
- crear túneles entre diferentes ubicaciones

Un caso muy habitual es utilizar WireGuard para acceder a tu *homelab* desde el móvil o el portátil estés donde estés, como si estuvieras conectado a tu red local.

Además, al ejecutar la VPN directamente en el router, todo el tráfico pasa por un único punto central de acceso, lo que simplifica tanto la configuración como el control de permisos y seguridad.

## Plugins y servicios adicionales

OPNsense incluye un sistema de plugins oficiales que permite ampliar fácilmente las funcionalidades del router. Gracias a este sistema puedes añadir nuevos servicios de red y seguridad sin tener que instalar software manualmente ni mantener configuraciones complejas.

En la práctica, esto permite que el router se convierta en una pequeña plataforma de servicios de red, centralizando muchas funciones que de otro modo requerirían servidores adicionales.

Algunos plugins especialmente interesantes son:

- [Zenarmor](https://docs.opnsense.org/vendor/sunnyvalley/zenarmor.html)
- [Unbound](https://docs.opnsense.org/manual/unbound.html)
- [CrowdSec](https://docs.crowdsec.net/u/integrations/opnsense/)
- AdGuard Home
- HAProxy
- ACME Client (Let's Encrypt)

Gracias a este ecosistema de plugins es posible integrar muchas funciones avanzadas directamente en el router, simplificando la arquitectura de red del *homelab*.

### Zenarmor

Sistema de inspección profunda de tráfico (DPI) que analiza el tráfico que pasa por el router para identificar aplicaciones y servicios utilizados en la red, aplicar políticas de filtrado o control de acceso basadas en ese tráfico y proporcionar estadísticas y paneles que ayudan a entender el uso de la red y detectar comportamientos anómalos.

### Unbound

Resolver DNS local que centraliza las consultas DNS de la red en el router, mejorando rendimiento mediante caché y privacidad al no depender del DNS del proveedor, y permitiendo bloqueos personalizados, overrides para dominios internos y funciones de seguridad como DNSSEC o DNS over TLS.

### CrowdSec

Sistema colaborativo de detección y bloqueo de ataques que analiza los logs del router y servicios de red para identificar comportamientos maliciosos (como fuerza bruta o escaneos de puertos), bloquear automáticamente las IPs atacantes mediante el firewall y utilizar inteligencia compartida de la comunidad para prevenir ataques conocidos.

### AdGuard Home

Permite bloquear publicidad y trackers a nivel de red interceptando las consultas DNS de los dispositivos y filtrando dominios conocidos por servir anuncios o contenido malicioso, aplicando el bloqueo automáticamente a toda la red y permitiendo gestionar listas, excepciones y estadísticas de uso.

### HAProxy

Balanceador de carga y reverse proxy que permite publicar servicios internos del homelab mediante un único punto de entrada en el router, redirigiendo el tráfico al servidor correspondiente según dominio, URL o puerto, y centralizando la terminación HTTPS mediante certificados TLS.

### ACME Client

Gestor automático de certificados TLS (por ejemplo de Let’s Encrypt), solicitándolos y renovándolos desde el router para habilitar HTTPS en servicios del homelab y centralizar su uso junto a plugins como HAProxy.

# Hardware necesario

OPNsense no requiere hardware propietario y puede instalarse en casi cualquier equipo x86: mini PCs (N100/N5105), appliances fanless, servidores reciclados o incluso máquinas virtuales.

Los requisitos son modestos: CPU x86_64, 2 GB de RAM (4 GB recomendados), 8 GB de almacenamiento y al menos dos interfaces de red. Para un *homelab* es recomendable usar una CPU con AES-NI, 4–8 GB de RAM, SSD y NICs Intel.

Lo más habitual es usar mini PCs fanless con 2–4 puertos Ethernet, que consumen entre 6 y 15 W y pueden funcionar 24/7 sin problema.

Un detalle importante es que OPNsense normalmente no gestiona el WiFi: lo habitual es separar router/firewall (OPNsense), switch y puntos de acceso dedicados (UniFi, Omada, etc.), lo que permite una red más flexible y escalable.

# Ventajas frente a routers comerciales

| Router doméstico | Router con OPNsense |
|------------------|----------------------|
| Funciones limitadas | Control total |
| Firmware cerrado | Código abierto |
| Actualizaciones irregulares | Updates frecuentes |
| Configuración simple | Configuración profesional |

La diferencia se nota especialmente cuando empiezas a experimentar con redes más complejas en tu *homelab*.

# Tiene sentido montar un router DIY?

Un router DIY con OPNsense no es necesario para todo el mundo; un router doméstico suele ser suficiente para la mayoría de usuarios. Sin embargo, empieza a tener sentido si tienes un *homelab*, quieres segmentar tu red, usar VPN, aprender networking o evitar las limitaciones de los routers domésticos. Si te interesa entender y controlar tu red, montar tu propio router es uno de los proyectos más interesantes que puedes hacer en un *homelab*.

# Curva de aprendizaje

OPNsense es relativamente fácil de usar comparado con otros firewalls profesionales, pero aun así no es un router plug-and-play. Para sacarle partido tendrás que familiarizarte con algunos conceptos básicos de redes, como routing, reglas de firewall, VLAN, NAT, DNS o VPN.

Al principio puede parecer complejo, especialmente si vienes de routers domésticos donde casi todo está automatizado, pero también es una buena oportunidad para entender cómo funcionan realmente las redes.

La buena noticia es que OPNsense facilita bastante el proceso: la interfaz de administración es clara, hay documentación muy completa y existe una comunidad activa que comparte guías y configuraciones. Con poco tiempo puedes tener una configuración básica funcionando y mejorarla poco a poco según tus necesidades.

# Cierre

Montar un router DIY con OPNsense es uno de esos proyectos que cambian bastante cómo entiendes tu propia red. Pasas de tener una "caja negra" que reparte Internet en casa, a tener control total sobre lo que ocurre en tu infraestructura de comunicaciones doméstica.

En esta serie de artículos voy a construir un router custom paso a paso, desde cero: elegiré el hardware, instalaré OPNsense, diseñaré la red de mi *homelab*, configuraré las VLAN, o el acceso remoto con VPN, entre otras cuestiones.

Si estás pensando en montar algo parecido, o ya estás jugando con OPNsense en tu casa, si tienes dudas, ideas o sugerencias, puedes comentarlas en el [canal de Telegram](https://t.me/lateclaescape). Allí solemos comentar este tipo de proyectos y ayudarnos entre todos.

Y si te interesan los *homelabs*, networking y proyectos de infraestructura casera, no te pierdas los próximos artículos, porque lo mejor todavía está por venir. Nos vemos en el próximo articulo.

Pulso la tecla `ESC:wq!`
