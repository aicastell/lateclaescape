---
title: Redes privadas virtuales
date: 2024-04-05
image: /img/posts/vpn.webp
categories: [ "redes", "ciberseguridad" ]
tags: [ "vpn", "isp" ]
draft: false
featured: true
---

# Motivación

En este artículo analizo las VPN a fondo. Desde su definición hasta cómo funcionan, pasando por las aplicaciones mas conocidas.

Si te interesa el mundo de la seguridad informática y las redes de comunicaciones, continúa leyendo. El contenido de este articulo te interesa.

Comencemos con una definición.

## ¿Que es una VPN?

Las Redes Privadas Virtuales, mas conocidas como VPN (Virtual Private Network) se han convertido en una herramienta indispensable para cualquier usuario que se preocupe por navegar de forma segura por Internet.

Una VPN es una herramienta que permite crear un **túnel** a través de una red pública como Internet. En el túnel VPN intervienen dos dispositivos:

- el cliente de la VPN
- el servidor de la VPN

El túnel entre el cliente y el servidor de la VPN se utiliza principalmente para transmitir datos de manera segura. Los datos atraviesan el túnel VPN encriptados. Cualquier intento de interceptar las comunicaciones por parte de terceros no autorizados será completamente inútil.


![tunel vpn](/img/vpn-schema.webp)

Este túnel encriptado se consigue mediante certificados digitales que se instalan tanto en el servidor como en los distintos clientes. Mas información sobre [certificados digitales](/post/2024/certificados-digitales) en el articulo referenciado.

La dirección IP del cliente es la que asigna tu proveedor de servicios de Internet (ISP) al dispositivo cliente (ordenador smartphone, tablet, etc). Esta dirección es la que se expone a Internet como origen de los paquetes. Puede utilizarse para conocer la ubicación geográfica aproximada del cliente. Los operadores de red y otros servicios en línea pueden utilizar esta información para aplicar restricciones geográficas u otras políticas de red.

La dirección IP del servidor es la dirección IP que identifica al servidor al que se conecta el cliente para establecer el tunel VPN.

Los datos viajan encriptados a través del túnel VPN. Cuando llegan al extremo del servidor VPN, se desencriptan para que el servidor pueda procesarlos. En este punto, el servidor VPN reenvía los datos desencriptados a su destino final en Internet. Utiliza su propia dirección IP como la dirección IP de origen de los paquetes, enmascarando así la dirección IP original del cliente. Esto hace que los servicios en línea vean la dirección IP del servidor VPN en lugar de la dirección IP real del cliente, lo que ayuda a proteger su privacidad al ocultar la dirección IP del usuario y por tanto su geolocalización.

## Ubicación del servidor

Dependiendo del uso que quieras hacer del servidor VPN es importante tener en cuenta su ubicación geográfica. Hay dos configuraciones posibles:

- Servidor VPN local
- Servidor VPN remoto

### Servidor VPN local

Un servidor VPN local se encuentra físicamente dentro de tu propia red local (LAN). En este escenario, los clientes externos se conectan al servidor VPN para acceder de manera segura a los recursos internos de la LAN desde ubicaciones externas. Algunas opciones comunes para alojar el servidor VPN en tu LAN incluyen:

- Servidor NAS
- Raspberry Pi
- Router compatible

### Servidor VPN remoto

Un servidor VPN remoto se encuentra físicamente fuera de tu propia red local (LAN). En este caso, los clientes se conectan al servidor VPN para ocultar su dirección IP pública y garantizar su privacidad y seguridad en línea al navegar por Internet. Las opciones para alojar este tipo de servidor VPN son dos:

- Un proveedor de VPN
- Un centro de procesamiento de datos (CPD)

Los proveedores de VPN son empresas que ofrecen un servidor de VPN ubicado en cualquier parte del mundo, a cambio de pagar una cuota mensual. Ellos se encargan de su instalación y configuración. Estos son los proveedores de VPN mas conocidos:

- [Nordvpn](https://nordvpn.com)
- [Protonvpn](https://protonvpn.com)
- [Surfshark](https://surfshark.com)

Los CPD son empresas donde puedes contratar un servidor (físico o virtual) ubicado en cualquier parte del mundo, a cambio de pagar una cuota mensual. En ese servidor puedes instalar cualquier cosa. Incluso tu propio servidor VPN. Requieren de mas conocimientos técnicos pero son mas económicos y flexibles. Algunas alternativas:

- [OVHcloud](https://www.ovhcloud.com)
- [Scaleway](https://www.scaleway.com)
- [Hostinger](https://www.hostinger.es)
- [Amazon Web Services (AWS)](https://aws.amazon.com/)
- [Google Cloud Platform (GCP)](https://cloud.google.com/)

## Aplicaciones VPN

Hay varias aplicaciones de software que incluyen tanto el cliente como el servidor VPN. Las mas populares son:

- [Openvpn](https://openvpn.net/)
- [Openconnect](https://www.infradead.org/openconnect/)
- [Wireguard](https://www.wireguard.com/)

Estas herramientas ofrecen funcionalidades de servidor VPN que permiten a los usuarios crear y administrar conexiones seguras desde y hacia sus redes, ya sea para acceder a recursos internos de la red o para navegar de manera segura por Internet.

## Casos de uso

A continuación enumero diez casos de uso de una VPN:

### Seguridad en redes publicas

Al conectar a redes WiFi públicas como las que encuentras en cafeterías, aeropuertos o hoteles, corres el riesgo de exponer tus datos personales. Una VPN encripta todos los datos que viajan a través del túnel VPN, lo que protege tus datos incluso en redes WiFi no seguras, preservando así tu información privada.

### Evitar la censura y vigilancia gubernamental

En países donde existe una fuerte censura en Internet o donde el gobierno lleva a cabo una vigilancia estricta de las actividades en línea, una VPN puede ayudar a los usuarios a eludir estas restricciones y navegar libremente por la web de manera anónima, protegiendo su privacidad frente a la vigilancia gubernamental.

### Proteger la privacidad al descargar archivos

Al utilizar una VPN para descargar archivos a través de redes peer-to-peer (P2P) o torrents, se oculta la dirección IP real, lo que proporciona un nivel adicional de anonimato y seguridad durante el intercambio de archivos.

### Acceso a los recursos internos de una empresa

Las empresas suelen utilizar VPNs para permitir que sus empleados accedan de forma segura a los recursos internos de la empresa desde ubicaciones externas. Esto es especialmente útil para aquellos empleados que teletrabajan o que viajan con frecuencia, garantizando la privacidad y seguridad de los datos empresariales.

### Evitar rastreos de actividad

Al utilizar una VPN, el tráfico de Internet se encripta, lo que impide que los ISP monitoricen y rastreen las actividades en línea de sus usuarios, protegiendo así su privacidad frente al seguimiento por parte de los ISP.

### Acceso a contenido restringido en ciertos países

Algunas plataformas de streaming imponen restricciones sobre ciertos contenidos en función de tu ubicación geográfica. Una VPN puede ayudar a los usuarios a eludir estas restricciones al enmascarar su ubicación y cambiar su dirección IP por otra con una ubicación geográfica diferente. Esto permite acceder a contenido que de otro modo estaría bloqueado, protegiendo así la libertad de acceso a la información en línea.

### Evitar la discriminación de precios

Algunas empresas utilizan técnicas de discriminación de precios basadas en la ubicación geográfica del usuario. Esto significa que el precio de productos y servicios en línea puede variar dependiendo de la región desde la cual se accede. Al utilizar una VPN para cambiar la ubicación geográfica, los usuarios pueden acceder a precios más bajos o mejores ofertas, protegiendo su privacidad financiera y evitando la discriminación de precios en línea.

### Acceso a redes domesticas

Una VPN también puede utilizarse para acceder de forma segura a los dispositivos y recursos de una red doméstica desde ubicaciones externas. Esto es especialmente útil para controlar dispositivos domésticos inteligentes, acceder a archivos almacenados en una red local o utilizar impresoras y otros dispositivos conectados a la red desde fuera de casa.

### Evitar limites de velocidad

Algunos ISP pueden limitar la velocidad de conexión para ciertos tipos de tráfico, como descargas de torrents o transmisiones de vídeo en línea. Una VPN puede ayudar a evitar estas limitaciones al encriptar el tráfico y ocultar su naturaleza, lo que puede resultar en una conexión más rápida y estable.

### Evitar el bloqueo de cuentas

En ciertos casos, las cuentas en línea pueden ser bloqueadas o restringidas debido a actividades sospechosas o violaciones de los términos de servicio. Utilizar una VPN puede ayudar a eludir estas restricciones al cambiar la dirección IP y evitar ser identificado como el mismo usuario que causó el bloqueo.

## Cuestiones legales

Nunca hagas uso de una VPN para hacer cosas ilegales.

Los datos entre el cliente y el servidor de la VPN van encriptados. Por tanto la conexión VPN es segura, si. Pero la conexión VPN no es privada, debido a que la IP publica del servidor de la VPN generalmente va asociada a un contrato. Este contrato puede ser:

- Con el ISP al que le pagas tu cuota mensual
- Con el CPD donde contratas el servidor
- Con el proveedor del servicio VPN

La persona física o jurídica vinculada con este contrato es legalmente responsable de cualquier actividad ilegal realizada desde esa dirección IP. Por lo tanto, es crucial utilizar los servicios de VPN de manera ética y legal, ya que el uso indebido puede tener repercusiones legales tanto para el proveedor de la VPN como, en última instancia, para los usuarios involucrados.

## Despedida

En artículos posteriores voy a mostrarte como instalar por ti mismo un servidor VPN como openvpn o wireguard. Si te interesa esta información, atento porque habrá mas artículos sobre VPNs.

Espero que este artículo haya disipado las dudas que pudieras tener sobre el funcionamiento de una VPN. Si tienes preguntas adicionales, consideras que falta información, deseas compartir datos relevantes o simplemente quieres pasarte a saludar, te invito a unirte al [canal de Telegram](https://t.me/lateclaescape).

Te agradezco sinceramente que hayas dedicado tiempo a leer este artículo y espero volver a verte pronto por aquí. Un saludo y ¡hasta el próximo articulo!.

Pulso la tecla ESC, dos puntos wq!
