---
title: La red de Bitcoin
date: 2024-08-09
image: "/img/posts/bitcoin-node-network.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "nodos", "Bitcoin network", "mesh network", "protocolo de difusión"]
draft: false
featured: true
---

# Motivación

En el artículo anterior de este blog he hablado sobre [nodos de Bitcoin](/posts/bitcoin-nodes). Sin entrar en muchos detalles, has aprendido que es un nodo de Bitcoin y cuales son sus funciones principales. Si no lo has leído todavía, antes de continuar te recomiendo que empieces por su lectura.

El tema de los nodos de Bitcoin es extenso y no ha hecho mas que empezar. Hay muchos temas a tratar. Seguiremos hablando sobre los nodos de Bitcoin y sobre sus funciones en próximos artículos.

En este articulo voy a seguir profundizando sobre este asunto. Hoy vas a aprender cómo se interconectan los nodos entre si para formar la red de Bitcoin. Una vez entiendas esto, estarás preparado para poner el valor todas las características que aporta esta red a sus usuarios.

## Red de Bitcoin

Todos los nodos de Bitcoin están conectados a través de Internet, formando una red de malla o **mesh network**, distribuida y descentralizada, que se conoce como la **red de Bitcoin**.

En el portal [bitnodes.io](https://bitnodes.io/nodes/) puedes ver el número exacto de Nodos activos en la red de Bitcoin. En el momento exacto que escribo estas lineas, son 19304 nodos activos.

Cada nodo de la red de Bitcoin se conecta solamente con algunos nodos cercanos (vecinos), evitando la necesidad de que cada nodo mantenga una conexión abierta con el resto de los nodos de la red, lo que sería extremadamente ineficiente.

Para que entiendas lo que es una red en forma de malla, piensa en una red de pesca. Imagina que cada nudo representa un nodo de Bitcoin y los hilos que conectan esos nudos son las conexiones entre ellos. En esta red de pesca, cada nudo está conectado a varios nudos cercanos a través de hilos, formando una estructura interconectada y resistente.

### Difusión en la red

Todos los nodos de la red de Bitcoin deben mantener una copia exacta y actualizada de toda la información relevante en todo momento. Esta capacidad de mantener una copia consistente es fundamental para el correcto funcionamiento de Bitcoin.

Cada vez que un nodo de la red realiza una acción que genera nueva información, es esencial que esta información se distribuya eficientemente a todos los nodos de la red. ¿Cómo se logra esto?

El proceso de distribución se lleva a cabo mediante un método eficiente de propagación entre nodos vecinos, conocido como el **protocolo de difusión** de la red.

Cada nodo transmite la información a sus nodos vecinos, quienes a su vez la retransmiten a los suyos, asegurando así una rápida diseminación a lo largo de todos los nodos que forman la red.

## Características

Gracias a esta capacidad de distribuir la información de forma tan rápida y mantener una replica exacta de la información en todos los nodos, la red de Bitcoin aporta una enorme cantidad de características al sistema y ofrece enormes ventajas respecto a los sistemas financieros tradicionales:

- Seguridad
- Transparencia
- Inmutabilidad
- Pseudo anonimato
- Resilencia
- Globalidad
- Autonomía
- Accesibilidad
- Bajos costos de operación
- Innovación
- Redundancia
- Descentralización
- Escalabilidad

Veamos cada una de estas características por separado:

### Seguridad

La red de Bitcoin es extremadamente segura gracias a su robusto algoritmo de consenso y avanzadas técnicas criptográficas. Esto dificulta enormemente que un atacante pueda modificar la información almacenada en el sistema.

### Transparencia

La información que gestiona la red de Bitcoin es pública y verificable por cualquier persona. Esto asegura la transparencia, ya que cualquiera puede auditar la red y verificar la información sin necesidad de confiar en una entidad central.

### Inmutabilidad

Una vez que la información ha sido registrada y confirmada en la red, no puede ser alterada ni eliminada. Esto proporciona un registro permanente y confiable de todas las acciones realizadas.

### Pseudo anonimato

Las operaciones en Bitcoin no están directamente vinculadas a identidades personales, sino a [direcciones de Bitcoin](/posts/bitcoin-address) únicas. Aunque la red es pública, la identidad de los usuarios detrás de las direcciones puede mantenerse relativamente anónima.

### Resilencia

Debido a su estructura distribuida, la red de Bitcoin es muy resistente a ataques y fallos. La red puede continuar funcionando correctamente incluso si varios nodos fallan o son atacados.

### Globalidad

La red de Bitcoin opera a nivel global y no está sujeta a las fronteras nacionales. Esto permite a las personas participar desde cualquier parte del mundo sin restricciones geográficas.

### Autonomía

Bitcoin permite a los usuarios tener control total sobre sus fondos sin la necesidad de intermediarios como bancos o gobiernos. Esto proporciona una mayor autonomía financiera y reduce la dependencia de instituciones tradicionales.

### Accesibilidad

Cualquier persona con acceso a Internet puede participar en la red de Bitcoin. No se requiere una infraestructura bancaria tradicional, lo que permite que personas no bancarizadas puedan acceder a servicios financieros básicos.

### Bajos costos de operación

Las operaciones en la red de Bitcoin son más económicas que las tradicionales, especialmente para transferencias internacionales, debido a la eliminación de intermediarios y la eficiencia del sistema.

### Innovación

La red de Bitcoin ha abierto las puertas a la creación de nuevas tecnologías y servicios, como contratos inteligentes y aplicaciones descentralizadas (DApps), que aprovechan la infraestructura subyacente.

### Redundancia

En la red de Bitcoin, cada nodo puede unirse o salir de la red en cualquier momento sin afectar el funcionamiento global. Cuando un nodo deja de estar disponible, ya sea por un fallo o por una desconexión voluntaria, los nodos vecinos detectan la pérdida de conexión y buscan otros nodos disponibles para establecer nuevas conexiones y mantener la red de malla interconectada.

### Descentralización

La red de Bitcoin no tiene un punto central de control. Cada nodo tiene la misma importancia en el mantenimiento y operación de la red. Si hubiera nodos centrales que guardaran información crítica o realizaran cálculos especiales, Bitcoin perdería todo su valor, ya que su característica única es la confianza en el consenso de la mayoría. Al ser completamente distribuida, incluso si algunos países censuraran su uso, la red de Bitcoin seguiría operando en otros países.

### Escalabilidad

La red de Bitcoin puede crecer añadiendo más nodos, lo que fortalece la red y mejora su capacidad para manejar más operaciones.

## Ejemplo de red de Bitcoin

Estas leyendo un articulo con fines educativos. Poner como ejemplo una red de 19304 nodos puede ser complicado de asimilar. Voy a modelar la red de Bitcoin simplificando mucho la realidad.

Imagina que la red de Bitcoin es mucho más pequeña y manejable, y estuviera compuesta solamente por 5 nodos, a los que nombrare utilizando las siglas BN (Bitcoin Node). Estos 5 nodos estarán geográficamente distribuidos por todo el mundo. Aunque cada nodo puede funcionar sin tener un wallet configurado, si uno de estos nodos realiza una operación importante, se perdería su recompensa. Por tanto, es aconsejable tener un wallet configurado en cada nodo. Así, tendremos:

| Nodo | Ubicación       | Wallet |
|------|-----------------|--------|
| BN1  | Estados Unidos  | WL1    |
| BN2  | Rusia           | WL2    |
| BN3  | China           | WL3    |
| BN4  | Australia       | WL4    |
| BN5  | España          | WL5    |

Utilizaremos esta red de Bitcoin en próximos artículos. Referenciaré a este articulo cuando sea necesario, para que no te pierdas.

## Despedida

En este artículo, has descubierto cómo los nodos de Bitcoin se organizan en una red de malla que es descentralizada, distribuida, escalable, resiliente y global. Esta estructura es clave para entender por qué Bitcoin es una de las tecnologías más robustas e innovadoras desarrolladas hasta la fecha.

Mi objetivo esta siendo mantener la explicación dentro de los conceptos previamente introducidos en el blog, aunque a medida que avanzamos, es inevitable que surjan nuevos temas debido a la complejidad y la importancia de las funciones que desempeñan los nodos de Bitcoin. Espero que el contenido sea claro y que el orden en que presento la información te ayude a construir un conocimiento sólido y coherente sobre este fascinante mundo.

Recuerda que siempre puedes unirte al  [canal de Telegram](https://t.me/lateclaescape) para compartir tus dudas, comentarios o sugerencias. Continuaré abordando todos los temas pendientes en futuros artículos, así que mantente atento.

Por ahora, esto es todo. Gracias por leer y nos vemos en el próximo artículo.

Pulso la tecla ESC, dos puntos wq!

