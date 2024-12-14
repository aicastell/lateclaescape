---
title: Router Xiaomi AX3600
date: 2024-12-14
image: /img/posts/router-xiaomi-ax3600.webp
categories: [ "tecnología", "router", "redes", "review" ]
tags: [ "beanforming", "MIMO", "Wi-Fi", "OFDMA", "router", "xiaomi", "AX3600" ]
draft: false
featured: true
---

# Introducción

El [Xiaomi AX3600](https://www.mi.com/global/product/mi-aiot-router-ax3600/) es un router compatible con el estándar Wi-Fi 6. Es un dispositivo pensado para ofrecer conexiones inalámbricas rápidas y estables, para usuarios que buscan el máximo rendimiento y flexibilidad en sus redes domésticas o empresariales.

En este artículo detallo las características internas de este dispositivo, para poner en valor sus puntos fuertes, pero también para alertar sobre sus puntos debilidades. Al finalizar haré una valoración personal.

# Diseño

El Xiaomi AX3600 tiene una estructura triangular alargada con bordes suavemente curvados. Sus dimensiones aproximadas de 35 cm de largo y 8 cm de alto lo posicionan como un dispositivo de gran tamaño en su categoría. A su estructura van unidas 7 antenas externas por lo que, en conjunto, el router requiere un espacio considerable para su correcta instalación.

![Xiaomi AX3600 online](/img/router-xiaomi-ax3600-online.webp)

En su parte central, el AX3600 dispone de dos indicadores LED dispuestos verticalmente que muestran el estado de la alimentación y la conexión.

Las rejillas de ventilación, situadas tanto en los bordes laterales como en la parte superior, permiten mantener el dispositivo a una temperatura adecuada, sin comprometer su estética.

# Hardware

Los fabricantes de los principales componentes de este router, tanto *Qualcomm* como *Xiaomi*, son bastante reservados y recelan de revelar muchos detalles internos de sus dispositivos. Sin embargo en la tecla ESC hemos podido averiguar bastante información que comparto a continuación:

## CPU

El cerebro de la bestia es un SoC (System on Chip) *Qualcomm* Atheros IPQ8071A, que tiene 4 núcleos ARM Cortex-A53 a 1.0 GHz. Podrían haber elegido el IPQ8074A, que tiene 4 núcleos a 2.4Ghz. Pero el precio es bastante mas elevado. Los Cortex-A53 son procesadores de bajo consumo y arquitectura ARMv8-A (64 bits), diseñados para ofrecer un equilibrio óptimo entre rendimiento y eficiencia energética. Esta es la CPU responsable de manejar las operaciones generales del router, incluyendo el procesamiento de datos de la red Wi-Fi 6.0 (802.11ax).

![Qualcomm Atheros IPQ8071A](/img/router-xiaomi-ax3600-ipq8071a.webp)

El gráfico anterior revela la presencia de 2 Networking Processing Units (NPU) Dual Core Ubi32 a 1.5GHz. Por tanto el IPQ8071A tiene en realidad 6 cores. He buscado bastante sobre estos NPU, pero no he encontrado mas información. Si alguien tiene mas datos, agradecería que los comparta por el [canal de Telegram](https://t.me/lateclaescape) para completar este articulo.

## Memoria RAM

El Xiaomi AX3600 cuenta con un chip de memoria RAM DDR3 [EM6HE16EWAKG-10H](https://etron.com/wp-content/uploads/2022/04/EM6HE16EWAKG-1866Mbps_Rev-1.3.pdf) de *Etron Technology*, con una capacidad de 512MB, de los cuales 416MB están disponibles para el sistema operativo y el resto se reserva para el kernel.

## Radios y antenas

El Xiaomi AX3600 está equipado con tres circuitos de radio independientes:

- QCN5054 (5GHz)
- QCN5024 (2.4GHz)
- QCA9889 (5GHz)

Cada circuito de radio está diseñado para operar en una banda de frecuencias específica. La combinación de estos elementos asegura un funcionamiento eficiente y robusto del router.

### El chip QCN5054

El QCN5054 es un chip transceptor de radio fabricado por *Qualcomm*, diseñado para manejar conexiones inalámbricas Wi-Fi 6 (802.11ax). Su tarea principal es gestionar las señales de radiofrecuencia para la transmisión y recepción de datos. Está diseñado para trabajar en la banda de 5 GHz, ofreciendo velocidades de transferencia elevadas a cambio de un menor alcance en comparación con la banda de 2.4 GHz. Este circuito soporta tecnología 4x4 MIMO (Multiple Input, Multiple Output), permitiendo hasta cuatro flujos simultáneos de 600 Mbps cada uno, con una capacidad teórica combinada de 2400 Mbps. El AX3600 incluye 4 antenas para trabajar con este chip, optimizando el rendimiento de la banda de 5 GHz.

Gracias a la técnica de agregación de canales, puede combinar canales de 20 MHz para formar anchos de banda mayores. Con 4 canales puede formar un canal de 80 MHz. Y con 8 canales, puede formar un canal de 160 MHz. En entornos compatibles esto mejora significativamente la velocidad. Al ser un chip compatible con Wi-Fi 6, incorpora la tecnología OFDMA (Orthogonal Frequency Division Multiple Access), que aumenta la eficiencia en redes densas al permitir comunicaciones simultáneas en subcanales separados.

Este chip está diseñado para manejar dispositivos con altas demandas de ancho de banda, como televisores 4K y consolas de videojuegos, maximizando la eficiencia y el rendimiento en redes de alta densidad.

### El chip QCN5024

El QCN5024, también fabricado por *Qualcomm*, es un chip transceptor de radio diseñado para manejar conexiones inalámbricas Wi-Fi 6 (802.11ax). Está diseñado para trabajar en la banda de 2.4 GHz, ofreciendo un mayor alcance y capacidad de penetrar obstáculos, aunque con velocidades más bajas que la banda de 5 GHz. Este circuito soporta tecnología 2x2 MIMO, permitiendo hasta dos flujos de datos simultáneos de 286 Mbps cada uno, con un máximo teórico combinado de 574 Mbps. El AX3600 incluye 2 antenas para trabajar con este chip, optimizando el rendimiento de la banda de 2.4 GHz.

También admite agregación de canales, pudiendo combinar 2 canales de 20 MHz para formar uno de 40 MHz, optimizando el rendimiento en áreas menos saturadas. En entornos congestionados, los canales de 20 MHz suelen ser más estables y eficientes. Es compatible con Wi-Fi 6 y por tanto incorpora OFDMA, lo que mejora la eficiencia en redes densas.

Este chip es ideal para dispositivos de baja a media demanda de datos, como sensores IoT, equipos inteligentes del hogar y smartphones, priorizando la estabilidad y el alcance de la señal, y garantizando un rendimiento confiable.

### El IC QCA9889

El QCA9889, también de *Qualcomm*, es un chip transceptor de radio mas antiguo. Esta diseñado para trabajar en la banda de 5 GHz (Wi-Fi 5, 802.11ac) y en la banda de 2.4 GHz (Wi-Fi 4, 802.11n). Este circuito soporta 1x1 MIMO, permitiendo un único flujo de datos con un máximo teórico de 433 Mbps. El AX3600 incluye 1 antena para trabajar con este chip, descargando de estas tareas a la CPU principal.

También admite agregación de canales. Puede combinar 2 canales de 20 MHz para formar uno de 40 MHz, o incluso 4 canales de 20 MHz para formar un solo canal de 80 MHz. Al no ser un chip compatible con Wi-Fi 6, no soporta la tecnología OFDMA.

Este chip destaca por su eficiencia energética, siendo ideal para dispositivos alimentados con batería como tablets, smartphones y laptops. Aunque su rendimiento máximo es inferior al del chip QCN5054, su enfoque en flujos de datos más específicos lo convierte en un componente esencial para balancear la carga de tráfico en la red del AX3600.

## Memoria flash

El Xiaomi AX3600 utiliza un chip de memoria NAND flash de 256 MB. Mi router lleva el modelo [GD9FS2G8F2A](https://www.gigadevice.com.cn/Public/Uploads/uploadfile/files/20220706/DS-00880-GD9FS2G8F2A-Rev1.1.pdf), fabricado por la empresa china *Gigadevice*. Sin embargo, otros usuarios reportan el uso del chip W29N02GZSIBA, fabricado por la taiwanesa *Winbond Electronics*. Seguramente haya mas variantes.

## Puertos

El Xiaomi AX3600 cuenta con un puerto WAN y tres puertos LAN Ethernet Gigabit (1000 Mbps), ofreciendo conexiones cableadas rápidas y estables, ideales para entornos que requieren alta estabilidad y amplio ancho de banda.

![Xiaomi AX3600 LAN WAN ports](/img/router-xiaomi-ax3600-1wan-3lan-ports.webp)

### Puerto WAN

El puerto WAN (Wide Area Network) soporta Ethernet Gigabit y se utiliza para conectar el router a la red externa, a través del módem del operador que provee el acceso a Internet. Permite que el router gestione conexiones de alta velocidad a Internet.

### Puertos LAN

Los tres puertos LAN (Local Area Network) también soportan Ethernet Gigabit, y son ideales para conectar dispositivos dentro de la red local del hogar o de la oficina que tengan un alta demanda de datos, como ordenadores personales, consolas de videojuegos, dispositivos que soporten streaming en 4K o sistemas tipo NAS.

# Firmware oficial

El router AX3600 no solo sobresale por su hardware, sino también por las tecnologías avanzadas que *Xiaomi* incorpora en su firmware, que mejoran el rendimiento en redes congestionadas y optimizan la experiencia Wi-Fi en entornos con alta demanda. Sin embargo, estas características son **nativas del firmware de *Xiaomi***, y pueden no estar completamente operativas si cambias el firmware oficial de *Xiaomi* por [OpenWrt](/post/2024/openwrt).

- Beanforming
- Smart network management
- Mesh networks

## Beamforming

El Xiaomi AX3600 es compatible con la tecnología **Beamforming**, que mejora la calidad y el alcance de la señal Wi-Fi al dirigirla hacia los dispositivos conectados, en lugar de emitirla de forma omnidireccional. Todos los chips de radio del router soportan esta tecnología.

## Smart Network Management

El **Smart Network Management** es una tecnología implementada por *Xiaomi* que optimiza el rendimiento de la red en tiempo real, seleccionando dinámicamente canales y gestionando las bandas de 2.4 GHz y 5 GHz para reducir la congestión. Esto mejora la estabilidad y permite que el AX3600 mantenga un alto rendimiento incluso en entornos con muchos dispositivos conectados, ofreciendo una experiencia Wi-Fi más fluida y sin interrupciones.

## Mesh network

Una **mesh network** (red mallada) conecta varios routers y puntos de acceso para ampliar y estabilizar la cobertura en áreas grandes o con obstáculos. A diferencia de una red Wi-Fi tradicional, los nodos de una red mesh se interconectan y permiten que los dispositivos se conecten automáticamente al nodo con la mejor señal. El Xiaomi AX3600 es compatible con redes mesh a través de **Mi Wi-Fi**, la aplicación de *Xiaomi* para gestionar sus dispositivos, lo que facilita la creación de una red mallada entre varios routers de la marca, mejorando la cobertura en espacios grandes o con paredes gruesas.

# Valoración personal

> Quiero dejar claro que *Xiaomi* no me paga nada por hacer esta valoración, y que la hago usando exclusivamente mi criterio personal.

## Ventajas

El Xiaomi AX3600 es un router de alto rendimiento que ofrece una excelente relación calidad-precio. Es una opción asequible que ofrece prestaciones similares a routers de gama alta como los de *ASUS*, *Netgear* o *Huawei*, a un precio aproximado de 50€ en tiendas de segunda mano (wallapop).

Su compatibilidad con el estándar Wi-Fi 6 lo posiciona como una opción relevante a largo plazo.

El Xiaomi AX3600 tiene una excelente compatibilidad con [OpenWrt](/post/2024/openwrt), lo que asegura que el dispositivo se mantendrá actualizado durante muchos años. Al instalar este sistema operativo, abres un abanico de posibilidades para personalizar la configuración, optimizar el rendimiento y mejorar la seguridad de tu propia red de área local.

Por todo esto, se trata de un dispositivo ideal para entusiastas de las redes informáticas.

## Inconvenientes

El Xiaomi AX3600 es considerablemente grande, por lo que puede no ser adecuado si buscas un dispositivo más pequeño o compacto, especialmente si el espacio disponible para instalarlo es limitado o prefieres un diseño más discreto.

El AX3600 no incluye ningún puerto USB, una característica que podrías echar en falta si quieres compartir datos de un disco duro, compartir impresoras en red, o incluso conectar un router 4G/5G como dispositivo de respaldo en caso de caída de tu ISP.

Echo en falta memoria DDR4 mas rápida, aunque según *Xiaomi*, la DDR3 es suficiente para manejar las necesidades de enrutamiento y procesar múltiples flujos de datos en redes Wi-Fi 6 (802.11ax), sin afectar el rendimiento en la mayoría de los casos.

Muchas funcionalidades avanzadas, como el Beamforming, la mesh network, o el Smart Network Management, dependen exclusivamente del firmware de *Xiaomi* y su funcionamiento no está garantizado si instalas [OpenWrt](/post/2024/openwrt).

# Despedida

Tras instalar el firmware de OpenWRT, he convertido a este dispositivo en el router principal de mi casa. En el próximo artículo te explicaré paso a paso como lo hice, para que tu también puedas aprovechar al máximo las capacidades de este router y disfrutar durante años de la libertad que ofrece un firmware completamente abierto. Así que, ¡no te lo pierdas el próximo articulo!

Si estás considerando comprar este dispositivo y tienes alguna pregunta, no dudes en contactarme a través del [canal de Telegram](https://t.me/lateclaescape). Estaré atento para resolver cualquier cuestión que quieras plantear sobre este router en particular. ¡Nos vemos en el próximo articulo!

Pulso la tecla ESC, dos puntos wq!
