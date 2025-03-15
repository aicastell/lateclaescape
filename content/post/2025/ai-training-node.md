---
title: AI training node
date: 2025-03-09
image: /img/posts/ai-training-node.webp
categories: [ "tecnología", "AI", "inteligencia_artificial" ]
tags: [ "training_node", "dual_channel", "TDP", "GPU", "MOBO", "CPU", "PSU", "SDP", "turbo_boost" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/ai-training-node.mp3" >}}

# Introducción

Un CPD de Barcelona contacta para explicarnos que quiere montar un equipo para entrenar modelos de inteligencia artificial de un tamaño medio. Estos equipos requieren hardware bastante potente y eso no es nada barato. Disponen de un PC relativamente nuevo, y quieren reciclar algunas piezas para este proyecto. Me piden ayuda para elegir los componentes e intentar montar un equipo enrackable que tenga un coste razonable.

Utilizaré las siguientes siglas durante todo el artículo:

- CPD: data processing center o centro de procesamiento de datos
- AI: artificial intelligence o inteligencia artificial
- CPU: *central processing unit* o unidad central de proceso
- MOBO: *motherboard* o placa base
- PSU: *power supply unit* o fuente de alimentación
- GPU: *graphical processing unit* o tarjeta gráfica
- TDP: *thermal design power* o potencia de diseño térmico
- SPD: *serial presence detect* o detección de presencia serial

# Listado de componentes

Este es el listado de componentes que voy a aprovechar del equipo reciclado:

- MOBO: [MSI Z490-A PRO](https://es.msi.com/Motherboard/Z490-A-PRO/Overview)
- CPU: [Intel Core i7 10700 a 3.6GHz](https://www.intel.la/content/www/xl/es/products/sku/199316/intel-core-i710700-processor-16m-cache-up-to-4-80-ghz/specifications.html)
- RAM: 1x32GB [Kingston Fury Beast DDR4](https://www.kingston.com/en/memory/gaming/kingston-fury-beast-ddr4-memory)
- Storage: 2 x [Samsung 970 EVO Plus NVMe® M.2 SSD 1TB](https://www.samsung.com/us/computing/memory-storage/solid-state-drives/ssd-970-evo-plus-nvme-m-2-1-tb-mz-v7s1t0b-am/b2bapp/)

Y este es el listado de componentes nuevos:

- Chasis: [Rack 4U 19″ UK 4129 USB TYPE C de UNYKAch](https://unykach.com/es/profesional/rack-19/caja-rack-4u19-uk-4129-51912/)
- CPU Cooler: [Noctua NH-L9i](https://noctua.at/en/nh-l9i)
- GPU: [Asus ROG Strix GeForce RTX 3090 Gaming](https://rog.asus.com/es/graphics-cards/graphics-cards/rog-strix/rog-strix-rtx3090-o24g-gaming-model/)
- RAM: 1x32GB [Kingston Fury Beast DDR4](https://www.kingston.com/en/memory/gaming/kingston-fury-beast-ddr4-memory)
- PSU: [Corsair RM1000x](https://www.corsair.com/us/en/p/psu/cp-9020201-na/rmx-series-rm1000x-1000-watt-80-plus-gold-fully-modular-atx-psu-cp-9020201-na)
- Network: [ASUS XG-C100F PCI-e 10Gbps con puerto SFP+](https://www.asus.com/networking-iot-servers/wired-networking/all-series/xg-c100f/)
- Output airflow: 2 x [Noctua NF-A8 PWM](https://noctua.at/en/nf-a8-pwm)
- Input airflow: 2 x [Noctua NF-A12x25 PWM](https://noctua.at/es/nf-a12x25-pwm)

# Review de los componentes

## Chasis rack

El CPD requiere un equipo enrackable y silencioso. Para ello, elegimos el chasis Rack 4U UK4129 UNYKAch, con diseño estándar de 19 pulgadas, compatible con armarios rack profesionales. Su amplio espacio permite instalar una GPU de gran formato, optimizando el flujo de aire y garantizando una correcta refrigeración de los componentes.

![Rack chasis 4U](/img/ai-training-node-rack-chasis-4u.webp)

Este chasis ofrece una amplia compatibilidad de placas base: E-ATX, ATX, micro-ATX y mini-ITX. Admite fuentes de alimentación ATX y tarjetas gráficas de hasta 350 mm. Tiene dos asas frontales para una mejor introducción y extracción del rack. Su diseño incluye orificios de montaje muy precisos para montar la placa base, y orificios para montar un riel deslizante para una instalación rápida. Viene con toda la tornillería necesaria para el montaje.

## Placa base (MOBO)

Aprovechamos la placa base del equipo reciclado. Es la MSI Z490-A PRO, una placa ATX diseñada para procesadores Intel de 10ª y 11ª generación con socket LGA 1200 y chipset Z490. Está enfocada a usuarios que buscan un equilibrio entre rendimiento y precio, por lo que resulta ideal para una estación de trabajo robusta que necesite un sistema estable y escalable, sin gastar de más.

![MOBO](/img/ai-training-node-mobo.webp)

Esta placa cuenta con cuatro ranuras DIMM DDR4, soportando hasta 128GB de RAM con frecuencias de hasta 5000 MHz (OC). Dispone de dos ranuras M.2, una de ellas con disipador, y seis puertos SATA III para almacenamiento. Ofrece dos ranuras PCI-e x16 (una con refuerzo de acero para soportar tarjetas gráficas pesadas) y tres PCI-e x1. Incluye puertos USB 3.2 Gen 2 (Tipo A y C), 2.5Gb LAN para redes rápidas y salidas de vídeo HDMI y DisplayPort para gráficos integrados.

## Unidad central de proceso (CPU)

También decidimos aprovechar la CPU del equipo reciclado. Es un Intel Core i7-10700, un procesador de 10ª generación con litografía de 14nm basado en la arquitectura [Comet Lake](https://www.intel.la/content/www/xl/es/products/platforms/details/comet-lake-s.html), diseñado para el socket LGA 1200. Para entrenar modelos de AI, esta CPU ofrece un rendimiento aceptable en cargas de trabajo moderadas debido a sus 8 núcleos y 16 hilos, lo que permite manejar varios procesos en paralelo de manera eficiente.

![CPU INTEL I7 10700](/img/ai-training-node-cpu-i7-10700.webp)

Tiene una frecuencia base de 2.9 GHz, con un Turbo Boost de hasta 4.8 GHz, permitiendo un alto desempeño en aplicaciones que requieren velocidad de procesamiento. Su TDP es de 65W, pero puede superar los 150W en cargas altas de trabajo. Es compatible con memoria DDR4 hasta 2933 MHz.

## CPU Cooler

Para mantener fría la CPU, montamos un Noctua NH-L9i, un disipador compacto de perfil bajo y bajo nivel de ruido, diseñado principalmente para CPUs de bajo consumo.

![CPU COOLER](/img/ai-training-node-cpu-cooler.webp)

La CPU tiene un TDP de 65W, por lo que este cooler debería ser suficiente par enfriarla. Sin embargo, bajo cargas de trabajo intensas de larga duración, esta CPU puede alcanzar los 150W, por lo que sería recomendable monitorizar la temperatura de la CPU bajo carga de trabajo intensa, por si fuera necesario cambiar el cooler por otro con mayor capacidad de disipación.

## Pasta térmica

Para asegurar una transferencia térmica eficiente entre el procesador y el disipador, utilizo la pasta térmica Noctua NT-H1, que viene incluida con el propio cooler de la CPU. Es una pasta térmica de alto rendimiento, conocida por su baja resistencia térmica y facilidad de aplicación. Tiene una durabilidad de hasta 5 años.

## Memoria RAM

Aprovecho un módulo de 32GB Kingston FURY Beast DDR4 que proviene del equipo reciclado. Esta memoria está diseñada para tareas exigentes como gaming, edición de vídeo, renderizado y entrenamiento de modelos de AI. Para completar la configuración, añadimos un segundo módulo de 32GB, alcanzando un total de 64GB de RAM.

![RAM](/img/ai-training-node-ram-ddr4-kingston.webp)

Ambos módulos tienen una latencia CL16, pero el módulo reciclado funciona a 3000 MHz y el nuevo a 3200 MHz. Aunque lo ideal hubiera sido que tuvieran la misma velocidad, esto no será un problema, ya que la placa base usa tecnología SPD para leer las especificaciones de cada módulo y el UEFI ajusta la configuración en el controlador de memoria del procesador, igualando automáticamente la velocidad del módulo más rápido al del más lento para garantizar estabilidad.

Para entrenar modelos de AI, 64GB de RAM es adecuado para manejar datasets de tamaño medio, evitando cuellos de botella. Al usar dos módulos se aprovecha el modo **Dual Channel**, mejorando el ancho de banda y la velocidad de acceso a memoria, lo que beneficia el flujo de datos entre CPU, RAM y GPU. Además, esta configuración permite una futura ampliación a 128GB.

## Tarjeta gráfica (GPU)

Para entrenar modelos de AI hacen falta GPU's con mucha memoria VRAM. Las [NVIDIA H100](https://www.nvidia.com/en-us/data-center/h100/) tienen 80GB de VRAM, lo que las hace ideales para este propósito. Pero cuestan mas de 40000€, un precio absurdamente alto que nos fuerza a rebajar las expectativas.

Buscamos la GPU con la mejor relación calidad/precio. En este caso, consideramos que la RTX 3090 es una opción ideal, ya que ofrece 24GB de VRAM a un precio relativamente asequible. Encontramos una Asus ROG Strix GeForce RTX 3090 Gaming en wallapop que tiene buena pinta.

![GPU RTX 3090](/img/ai-training-node-gpu-rtx-3090.webp)

Esta es la GPU más potente de la serie RTX 30 de NVIDIA. Basada en la arquitectura [Ampere](https://www.nvidia.com/es-es/data-center/ampere-architecture/), cuenta con 24GB de memoria GDDR6X, un ancho de banda de 936GB/s, 10496 núcleos CUDA, 82 RT Cores y 328 Tensor Cores, esenciales para tareas de AI. Lo que la convierte en una auténtica bestia para aplicaciones profesionales.

## Almacenamiento

Para entrenar modelos de AI, es fundamental que los datos que se van a utilizar para entrenar el modelo se carguen rápido en la memoria, lo que evitará cuellos de botella. Para resolver este problema vamos a aprovechar los dos dispositivos de memoria NVME M.2 que trae el equipo reciclado. Se trata de dos unidades Samsung 970 EVO Plus NVMe M.2 SSD 1TB. En total 2TB de almacenamiento.

![Storage 2x1TB](/img/ai-training-node-storage-nvme-m2-1tb.webp)

Estas unidades destacan por su velocidad, siendo ideales para usuarios que necesitan un rendimiento superior en aplicaciones que manejan grandes volúmenes de datos, como en este caso.

Con una velocidad de lectura de hasta 3500 MB/s, el 970 EVO Plus maneja grandes volúmenes de datos de manera eficiente, lo que resulta esencial para entrenar modelos de AI, que requieren acceso rápido y continuo a un dataset enorme. Además, con una velocidad de escritura de hasta 3300 MB/s, el 970 EVO Plus permite almacenar y procesar rápidamente los datos durante el preprocesamiento, agilizando aún más el flujo de trabajo.

## Tarjeta de red

El CPD requiere una tarjeta de red con soporte para interfaz SFP+ a 10Gbps, por lo que incorporan en el setup la controladora de red ASUS XG-C100F.

![Tarjeta de red](/img/ai-training-node-network-card.webp)

Es una tarjeta PCI-e de 10Gbps con interfaz SFP+ en lugar de RJ45, compatible con módulos ópticos y cables DAC. Es compatible con Windows y Linux, con drivers integrados en los kernels más recientes.

## Fuente de alimentación (PSU)

El entrenamiento de modelos de AI puede hacer que tanto la GPU como la CPU trabajen al máximo durante largos periodos de tiempo. El TDP oficial de la ASUS ROG Strix RTX 3090 es de 350W, pero puede alcanzar picos de 450W bajo carga extrema. La CPU Intel Core i7 10700 tiene un TDP base de 65W, pero con **Turbo Boost** puede llegar a consumir hasta 150W en cargas intensivas. La placa base hasta 120W adicionales. Calculamos un consumo máximo de 720W. Por tanto, consideramos que una PSU de 1000W ofrece un margen de seguridad suficiente para evitar sobrecargas.

En este caso, elegimos la Corsair RM1000x, una fuente de alimentación ATX con certificación 80 Gold Plus, que garantiza una alta eficiencia energética, reduciendo el desperdicio de energía y la generación de calor.

![PSU](/img/ai-training-node-psu-corsair-1000w.webp)

Es una fuente totalmente modular, lo que permite conectar solo los cables necesarios, mejorando así el flujo de aire dentro del chasis y facilitando la gestión del cableado. Además, incorpora condensadores japoneses de alta calidad, que aseguran una mayor estabilidad, durabilidad y fiabilidad incluso en condiciones de carga exigentes.

Su ventilador con modo Zero RPM garantiza un funcionamiento completamente silencioso bajo cargas bajas o moderadas, activándose solo cuando es necesario para mejorar la refrigeración y optimizar el rendimiento térmico.

Lo que menos me ha gustado de esta fuente es que su cableado es bastante rígido, lo que dificulta su manejo y complica la organización dentro del chasis.

## Refrigeración

### Input airflow

Para garantizar un flujo constante de aire frío dentro del chasis, utilizaré dos ventiladores PWM Noctua NF-A12x25 de 120mm.

![Input airflow cooler](/img/ai-training-node-input-cooler.webp)

Están diseñados para ofrecer un flujo de aire excelente manteniendo un nivel de ruido extremadamente bajo, lo que los convierte en una de las mejores opciones del mercado para esta tarea. Además, son muy duraderos, con una garantía de 6 años proporcionada por Noctua. Aunque su precio es algo elevado, la calidad y el rendimiento que ofrecen justifican completamente su precio.

### Output airflow

Para extraer el aire caliente del chasis, utilizaré dos ventiladores PWM Noctua NF-A8 de 80mm.

![Output airflow cooler](/img/ai-training-node-output-cooler.webp)

Estos ventiladores jugarán un papel crucial en la expulsión del aire caliente, contribuyendo a mantener las temperaturas bajas en todos los componentes del sistema. Además, son extremadamente duraderos, con una garantía de 6 años proporcionada por Noctua. Están diseñados para ofrecer una alta eficiencia y un funcionamiento silencioso, asegurando un equilibrio perfecto entre rendimiento y bajo nivel de ruido.

# Montaje de componentes

Ha sido un montaje bastante largo, por lo que detenerme en explicar todo el proceso alargaría demasiado este articulo. Incluyo algunas fotos aquí:

![Montaje equipo paso1](/img/ai-training-node-montaje-paso1.webp)
![Montaje equipo paso2](/img/ai-training-node-montaje-paso2.webp)

El resto del material fotográfico sobre el [montaje del nodo](https://github.com/aicastell/repairable/tree/master/ai-training-node) y sobre el [proceso de limpieza de la GPU](https://github.com/aicastell/repairable/tree/master/asus-rog-strix-geforce-rtx-3090) están disponibles en los enlaces proporcionados.

# Prueba de encendido

El equipo queda listo para realizar la prueba de encendido. Parece que arranca todo bien al primer intento.

![Equipo encendido](/img/ai-training-node-switchon-working.webp)

# Despedida

El CPD de Barcelona posee ahora mismo una auténtica bestia diseñada para entrenar modelos de AI. Los números lo dicen todo: una CPU de 8 núcleos y 16 hilos, 64GB de RAM, almacenamiento NVME M.2 de 2TB, y una RTX 3090 con 24GB de VRAM, alimentado por una fuente de 1000W con certificación 80 Gold Plus. Este proyecto demuestra que, con un poco de sentido común y aprovechando componentes reciclados, se puede crear una bestia de cálculo increíblemente potente sin necesidad de gastar una cantidad de dinero desproporcionada.

Si tienes algún proyecto en mente y necesitas montar un equipo con características especiales, no dudes en contactar a través del [canal de Telegram](https://t.me/lateclaescape) o enviando un correo a lateclaescape@gmail.com. Estaré encantado de estudiar tu caso y ayudarte a encontrar la mejor solución.

¡Nos vemos en el próximo artículo!

Pulso la tecla ESC, dos puntos wq!

