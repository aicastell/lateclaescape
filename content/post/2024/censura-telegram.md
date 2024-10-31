---
title: Censura Telegram
date: 2024-04-01
image: "/img/posts/bloqueo-telegram.webp"
categories: [ "censura" ]
tags: [ "telegram", "DNS", "proxy", "VPN" ]
draft: false
featured: true
---

# Motivación

Se trata de la noticia bomba del fin de semana.

Telegram, la popular aplicación de mensajería instantánea alternativa a Whatsapp, que cuenta con 8.5 millones de usuarios en España, sera bloqueada en nuestro país de manera cautelar por orden del juez de la Audiencia Nacional, *Santiago Pedraz*.

La decisión ha sido tomada como consecuencia de una denuncia presentada por [Mediaset](https://www.mediaset.es/), [Antena 3](https://www.antena3.com/) y [Movistar](https://www.movistar.es/), quienes acusan a la aplicación de alojar contenido protegido por derechos de autor sin su permiso.

En el momento de publicar este artículo, la aplicación sigue funcionando con normalidad. Sin embargo, probablemente deje de estar operativa en las próximas horas, una vez que las distintas empresas de telecomunicaciones lleven a cabo el bloqueo impuesto por el juez de la Audiencia Nacional.

En este articulo te explico maneras de evitar el bloqueo y mi opinión sobre lo sucedido.

## Arquitectura de Telegram

Telegram esta actualmente compuesto por una infraestructura descentralizada y multi Data Center. Cada uno de esos Data Centers pueden funcionar de forma independiente. Hasta donde llegan mis conocimientos, tienen dos Data Centers en Miami, dos en Amsterdam y uno en Singapur.

## Posibles bloqueos y soluciones

El bloqueo se podría hacer efectivo de dos maneras diferentes:

1. Servidores de nombre de dominio (DNS)
2. Direcciones IP de los Data Centers

### Servidores de nombre de dominio

Los operadores nacionales podrían modificar sus DNS para bloquear la resolución del nombre de dominio *telegram.org* en sus DNS.

Solucionar este problema sería un juego de niños. Bastaría con reconfigurar el DNS de nuestro dispositivo de navegación (teléfono, ordenador, etc). Para ello, cambiaríamos el DNS de nuestro operador por otro DNS libre que si realice la traducción del nombre en una IP. En [esta web](https://public-dns.info/) tienes una lista de alternativas. Algunos ejemplos:

- OpenDNS: 208.67.222.222 y 208.67.220.220
- Cloudflare: 1.1.1.1 y 1.0.0.1
- Google: 8.8.8.8, 8.8.4.4

Yo utilizo OpenDNS. No me gusta que Google tenga un historial de todos los sitios que visito ni que haga negocio con mis datos de navegación.

### Direcciones IP de los Data Centers

En el caso de bloqueo de las IP de los Data Centers de Telegram, el bloqueo lo podrían hacer los propios operadores nacionales de telecomunicaciones. ¿Como? Cuando ven un intento de conexión en el que detecten como dirección IP de destino alguna de los Data Centers de Telegram, simplemente bloquearían dicha conexión.

Sin embargo, es posible eludir este bloqueo utilizando un servidor intermedio situado fuera del territorio español, por ejemplo, en USA. En este proceso, establecemos una primera conexión con dicho servidor intermedio en USA. Este servidor, que se encuentra fuera de España y no está sujeto al control de los operadores nacionales, establece la conexión con el Data Center de Telegram. Actúa como intermediario en las comunicaciones, asegurando que nunca establezcamos una conexión directa con el Data Center de Telegram desde territorio nacional. Por consiguiente, la dirección IP de origen es la de USA, no la de España. Los operadores nacionales no observarán nada inusual al realizar esta primera conexión con el servidor de USA.

Esta solución se puede aplicar de dos formas diferentes:

- Proxy
- [Red privada virtual](/post/2024/vpn) (VPN)

El proxy es a nivel de aplicación, solo afecta a la aplicación Telegram. El resto de las aplicaciones de tu dispositivo funcionan con normalidad. El problema de los proxy es que las comunicaciones desde tu dispositivo hasta ese proxy intermedio puede que vayan cifradas o puede que no. Y ese servidor proxy podría estar espiando todas tus comunicaciones. Y eso no es recomendable en absoluto.

La VPN es a nivel de toda la red. Todo el trafico de tu dispositivo sale a través de tu VPN. Por tanto, afecta a todas las aplicaciones de tu dispositivo que conecten a Internet (correo electrónico, browsers, Whatsapp, Twitter, etc). Es mucho mas seguro que usar un proxy. Pero es posible que algunas aplicaciones te dejen de funcionar cuando navegues a través de una VPN.

Mis recomendaciones son dos:

- Servidor VPS
- Browser TOR

Si tienes conocimientos técnicos, puedes contratar un [servidor VPS](https://www.hetzner.com/cloud/) fuera de España (4€/mes). Dentro de ese servidor, te instalas tu propio [proxy de Telegram](https://github.com/9seconds/mtg) o tu propio [servidor VPN](https://github.com/linuxserver/docker-wireguard).

Si no tienes conocimientos técnicos, descarga el [browser TOR](https://www.torproject.org/es/download/). Este navegador tiene un servicio de VPN integrado. Desde TOR, abres la aplicación de Telegram, vía web. Y desde allí todo debería funcionarte con normalidad, sin censuras de ningún tipo.

## Despedida

Los juristas opinan que esta decisión es absolutamente desproporcionada. No se hace ante una amenaza de violencia, se hace para proteger los beneficios multimillonarios de las grandes corporaciones. Sería como cerrar todas las tiendas que venden cuchillos por un caso aislado de homicidio con arma blanca. No tiene ningún sentido ni fundamento jurídico.

Probablemente el cierre de Telegram solo será de unas pocas horas o días como mucho. Pero, ¿que pretenden realmente con este bloqueo?

Personalmente, considero que esto representa una prueba piloto para evaluar la capacidad de censura de los Gobiernos. Han elegido a España como el sujeto de esta prueba. Quieren controlar toda la información. No les gustan las aplicaciones que no tienen bajo su control. Es muy probable que tras éste lleguen otros intentos de censura. Ya hablan sin vergüenza de [prohibir las transacciones de criptomonedas](https://es.cointelegraph.com/news/eu-enacts-ban-on-anonymous-crypto-transactions-via-self-custody-wallets) entre wallets. No piensan parar.

Afortunadamente, los sistemas distribuidos fueron diseñados específicamente para contrarrestar este tipo de censuras. Nosotros somos la resistencia, y en momentos como este, cuando intentan infundir miedo en la población, la divulgación se convierte en nuestra mejor arma contra la opresión.

Pulso la tecla ESC, dos puntos wq!
