---
title: Comunicación entre paquetes en Go
date: 2026-01-11
image: /img/posts/golang-packages-import.webp
categories: [ "programming_language" ]
tags: [ "golang", "packages", "import" ]
draft: false
featured: true
---

# Introducción

En los artículos anteriores hemos definido el perímetro del proyecto con los [módulos Go](/post/2026/golang-modules) y hemos organizado el código en [paquetes Go](/post/2026/golang-packages). Sin embargo, una aplicación real no está formada por piezas aisladas: los paquetes necesitan colaborar entre sí.

En este artículo veremos cómo se comunican los paquetes en Go, qué reglas impone el lenguaje, cómo se controlan las dependencias internas y por qué estas decisiones influyen directamente en la arquitectura, la mantenibilidad y la claridad del código.

Si los módulos definen qué es el proyecto y los paquetes organizan su código, la comunicación entre paquetes define cómo se estructura realmente una aplicación Go.

# Importar paquetes en Go

En Go, la única forma de que un paquete utilice código definido en otro paquete es importándolo explícitamente mediante la palabra clave `import`.

Un paquete puede usar funciones, tipos o variables definidos en otro paquete siempre que:

- El paquete esté correctamente importado
- Los elementos que se quieran usar estén exportados

No existen accesos implícitos, referencias automáticas ni dependencias ocultas. Todas las relaciones entre paquetes son explícitas y verificables por el compilador.

# Rutas de importación

Para importar un paquete, se utiliza una ruta lógica compuesta por:

- El nombre del módulo (definido en `go.mod`)
- La ruta del paquete dentro del módulo

Supongamos esta estructura dentro de un módulo:

```
mi-proyecto/
├── go.mod
├── main.go
└── config/
    └── config.go
```

Y que el archivo `go.mod` contiene:

```
module github.com/lateclaescape/mi-proyecto
```

El paquete `config` reside en el directorio `config/` y se importa así:

```
import "github.com/lateclaescape/mi-proyecto/config"
```

donde:

- `github.com/lateclaescape/mi-proyecto` es el nombre del módulo
- `/config` es la ruta del paquete dentro del módulo

No hay nada implícito: la ruta de importación refleja exactamente la estructura del proyecto.

# Visibilidad: público vs privado

Los paquetes en Go están fuertemente aislados entre sí. Un paquete solo puede acceder a lo que otro expone explícitamente.

Go controla la visibilidad con una regla simple:

- Identificadores que empiezan por **mayúscula** son exportados (visibles fuera del paquete)
- Identificadores que empiezan por **minúscula** NO son exportados (privados del paquete)

Esta regla se aplica a:

- Funciones
- Tipos
- Variables
- Constantes
- Campos de structs

No existen palabras clave como `public`, `private` o `protected`, como ocurre en otros lenguajes. La intención es visible directamente en el nombre.

Ejemplo:

```
package utils

func PublicFunc() {}
func privateFunc() {}
```

Desde otro paquete que importe el paquete `utils`:

- `PublicFunc` es accesible (la inicial `P` esta escrita en mayúsculas).
- `privateFunc` no es accesible (la inicial 'p' esta escrita en minúsculas).

Esta convención obliga a definir conscientemente la API del paquete, reduce el acoplamiento y facilita refactorizaciones internas sin afectar a otros paquetes. A diferencia de lenguajes como Python, donde el acceso es más permisivo, esta es una decisión de diseño central en Go.

# Usar función de otro paquete

Veamos ahora un ejemplo completo y mínimo de comunicación entre paquetes.

```
$ cat config/config.go
package config

func Load() string {
    return "configuración cargada"
}
```

Este paquete expone la función `Load` porque la `L` empieza en mayúsculas, y por tanto es un símbolo público.

Su uso desde el fichero `main.go`

```
$ cat main.go
package main

import (
    "fmt"
    "github.com/lateclaescape/mi-proyecto/config"
)

func main() {
    msg := config.Load()
    fmt.Println(msg)
}
```

En este ejemplo:

- El fichero `main.go` importa el paquete `config`
- `config.Load` es accesible porque `Load` empieza por mayúscula
- La comunicación entre paquetes se hace exclusivamente a través de esa función

El paquete `main` solo conoce los símbolos exportados del paquete `config`:

- No accede a archivos del paquete `config`
- No sabe nada sobre la implementación de la función `Load`
- No depende de su implementación interna

# Diseñar una API de paquete

En Go, diseñar un paquete es diseñar una API, incluso cuando el paquete solo se usa internamente.

Un buen paquete en Go:

- Expone pocos símbolos
- Oculta los detalles de implementación
- Tiene una responsabilidad clara

La idea es que otros paquetes dependan solo de lo que ofrece, no de cómo lo implementa internamente.

Ejemplo:

```
package config

func loadFromFile() {
    // función privada
}

func Load() {
    return loadFromFile()
}
```

Aquí hay dos funciones:

- `Load` empieza por mayúscula, por tanto, es pública
- `loadFromFile` empieza por minúscula, por tanto, es privada al paquete

Desde otro paquete que importe el paquete `config`:

- Puedes llamar a `config.Load`
- No puedes llamar a `loadFromFile`
- No sabes (ni necesitas saber) cómo se obtiene la configuración

Este diseño permite cambiar la implementación interna sin afectar al resto del programa, reduciendo el acoplamiento y facilitando la evolución del código.

# Inicialización de paquetes en Go

Cuando un paquete se importa en Go, el lenguaje garantiza un orden de inicialización determinista:

- Se inicializan las variables globales del paquete importado.
- Se ejecutan sus funciones `init()`, si existen.
- Solo entonces se inicializa el paquete que realiza el `import`.

Este proceso ocurre **una sola vez por paquete**, aunque el paquete sea importado desde varios sitios.

Ejemplo simple:

```
package config

import "fmt"

func init() {
    fmt.Println("Init function config package")
}
```

Si este paquete es importado desde el paquete `main`, el mensaje se imprimirá automáticamente antes de ejecutar la función `main()`.

## La función init

La función init() tiene reglas muy específicas:

- No se puede llamar manualmente.
- No recibe parámetros ni devuelve valores.
- Puede haber varias funciones `init()` en el mismo paquete (incluso en distintos archivos).
- Se ejecuta automáticamente durante la inicialización del programa.
- Siempre se ejecuta antes de `main()`.
- No es un sustituto de los constructores de C++

La función `init()` está destinada a tareas como validaciones, registros o inicialización de estados globales.

Es importante explicar que abusar de `init()` introduce efectos secundarios implícitos que dificultan el razonamiento, las pruebas y el mantenimiento del código. En general, debe evitarse para lógica de negocio y reservarse para casos muy concretos.

En algunos casos, un paquete no se importa para usar sus funciones o tipos, sino únicamente para que se ejecute su inicialización. Go permite esto usando el identificador en blanco `_` en el import:

```
import _ "github.com/lib/pq"
```

Este import tiene un significado muy concreto:

- El paquete se importa.
- Se inicializan sus variables globales.
- Se ejecutan sus funciones init().
- Pero ninguno de sus símbolos queda accesible.

Este patrón se utiliza, por ejemplo, para que un driver de base de datos se registre automáticamente durante la inicialización.

Precisamente porque introduce efectos secundarios implícitos, su uso debe ser excepcional y deliberado.

# Alias de importación

Go permite usar alias para los imports:

Ejemplo:

```
import cfg "github.com/lateclaescape/mi-proyecto/config"

func main() {
    cfg.Load()
}
```

El alias `cfg` solo existe en el fichero fuente que lo declara, y no afecta al paquete original.

En proyectos grandes, donde los paquetes son piezas arquitectónicas, los alias ayudan a que el código refleje mejor las responsabilidades.

# Imports no usados prohibidos

Go no permite imports innecesarios. Todo `import` debe usarse, y todo símbolo usado, debe estar importado. Por ejemplo, este código no compila:

```
import "fmt"

func main() {}
```

El compilador genera este error:

```
fmt imported and not used
```

Esto obliga a mantener el código limpio y evita dependencias implícitas o olvidadas.

# Dependencias circulares prohibidas

Go no permite ciclos de importación. Es decir, está prohibido que un paquete A importe otro B, y que, a su vez, el paquete B importe a A.

Ejemplo:

```
mi-proyecto/
├── main.go
├── server/
├── storage/
└── config/
```

Relaciones válidas:

- `main` importa `server`
- `server` importa `config` y `storage`
- `config` no importa a nadie

Relaciones inválidas:

- `server` importa `storage`, y `storage` importa `server`

Go prohíbe las dependencias circulares. El compilador lo detecta, dará un error y abortará la compilación.

Esto obliga a replantear responsabilidades, extraer dependencias comunes a paquetes independientes y diseñar arquitecturas más claras.

# El directorio internal

Go proporciona un mecanismo adicional para controlar la visibilidad a nivel de módulo: el directorio `internal/`.

El directorio `internal/` permite expresar una intención clara en el diseño: este código forma parte de la implementación interna del módulo y no constituye una API pública. Un paquete dentro del directorio `internal/` solo puede ser importado por código que esté dentro del mismo módulo (o subárbol).

```
mi-proyecto/
├── go.mod
├── main.go
└── internal/
    └── secret.go
```

En este caso:

- El código dentro de `mi-proyecto/` puede importar `internal/secret`
- Cualquier otro módulo externo no puede hacerlo
- Intentar importar ese paquete desde fuera del módulo provoca un error de compilación.

Esto permite:

- Compartir código interno entre paquetes
- Evitar que otros proyectos dependan de implementaciones privadas
- Definir límites arquitectónicos claros

A diferencia de la visibilidad por mayúsculas, que actúa dentro de un paquete, `internal/` actúa entre paquetes y entre módulos.

# Conclusión

Dominar cómo se relacionan y comunican los paquetes en Go no es un detalle técnico menor: es la clave que diferencia un proyecto que simplemente “funciona” de uno que realmente se puede mantener, crecer y disfrutar durante años.

Las reglas estrictas de visibilidad, las importaciones explícitas, la prohibición absoluta de ciclos, el poderoso directorio internal/, o el uso consciente de init(). Todo esto forma un sistema de diseño que, aunque parezca estricto, se convierte en una de las mayores fortalezas de Go cuando los proyectos empiezan a ganar tamaño y complejidad.

Con lo visto hoy ya puedes empezar a crear paquetes con APIs limpias y bien intencionadas, reducir drásticamente el acoplamiento innecesario, definir límites arquitectónicos claros desde el primer commit y escribir código que sea comprensible y modificable incluso meses después cuando retomes un proyecto que tenías abandonado.

En el próximo artículo daré el siguiente paso natural: darle forma a los datos en Go. Exploraré los tipos básicos y sus zero values, pasando por structs, composición, embedding e interfaces, hasta descubrir por qué el sistema de tipos de Go es mucho más expresivo y elegante de lo que suele parecer a primera vista.

El perímetro ya está definido. Los paquetes ya están organizados. Ahora sí, toca modelar el corazón de la aplicación.

¿Has aprendido algo leyendo este artículo? Únete al [canal de Telegram](https://t.me/lateclaescape), y cuéntame qué tema te gustaría que abordara a continuación. Allí respondo personalmente a cada pregunta planteada. Muchas gracias por leerme y nos vemos en el próximo artículo!

Pulso la tecla `ESC:wq!`
