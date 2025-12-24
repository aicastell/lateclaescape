---
title: Router HTTP en Go
date: 2025-12-24
image: /img/posts/golang-router-http.webp
categories: [ "software", "programming_language" ]
tags: [ "golang", "router", "http" ]
draft: false
featured: true
---

# Introducción

En este artículo se aborda la construcción de un router HTTP desde cero en Go, sin depender de frameworks existentes. A través de un enfoque progresivo y práctico, se analizan los fundamentos del enrutamiento HTTP, el manejo de rutas y métodos, la estructura interna de un router eficiente y las decisiones de diseño que impactan en rendimiento, mantenibilidad y extensibilidad. El objetivo no es reinventar la rueda, sino comprender en profundidad cómo funciona por dentro una de las piezas clave de cualquier servidor web moderno.

# El router HTTP

Un router HTTP es un componente de software que recibe una petición HTTP (con su URL y método) y decide qué función (handler) debe ejecutar para responderla. Es como el repartidor de correo de tu aplicación web: mira la dirección (la URL), y entrega el paquete (la petición) al destinatario correcto (tu función Index, Contact, etc.). En este artículo vamos a desarrollar paso a paso un router custom HTTP desde cero. Nuestro objetivo es poder registrar dos rutas distintas "/" y "/status", y conteste con una respuesta custom para cada ruta.

Queremos este código:

```
r := CustomRouter()
r.HandleFunc("/", Index)
r.HandleFunc("/status", Status)
http.ListenAndServe(":8080", r)
```

# Estructura básica

Definimos una estructura llamada CustomRouter, de esta manera:

```
$ cat router-custom.go
package main

import "net/http"

type CustomRouter struct {
    ...
}
```

# El mapa de rutas

Necesitas un mapa para guardar las rutas y sus handlers asociados. Definimos este mapa dentro de la estructura CustomRouter:

```
$ cat router-custom.go
package main

import "net/http"

type CustomRouter struct {
    rutas map[string]http.HandlerFunc
}
```

El tipo Router guarda un mapa llamado "rutas" que almacena:

- como clave, un string
- como valor, un tipo http.HandlerFunc.

# El tipo http.HandlerFunc

Seguro que ahora te estas preguntando que demonios es un [http.HandlerFunc](https://pkg.go.dev/net/http@go1.25.5#HandlerFunc)

El tipo "HandlerFunc" es un tipo definido dentro del paquete "http". En la documentación oficial se define de esta manera:

```
type HandlerFunc func(ResponseWriter, *Request)
```

Es decir, "HandlerFunc" es solo un nombre bonito para una función que recibe como argumentos un ResponseWriter y un \*Request. Los tipos de ambos parámetros están definidos dentro del propio paquete "http".


## Lista de Handlers

Ahora implementamos dos callback diferentes, para poder usarlos en el main para registrar distintas rutas:

```
func Index(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("Página principal\n"))
}

func Status(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("Página de estado\n"))
}
```

Estas dos funciones son los callback que usaremos con cada una de las rutas que vayamos registrando.

## Registro de rutas

Ahora vamos a implementar un método del tipo \*CustomRouter. Este método permite registrar un handler (una función callback que maneja peticiones HTTP) para una ruta específica.

```
func (r *CustomRouter) HandleFunc(path string, handler http.HandlerFunc) {
    r.rutas[path] = handler
}
```

Esta función HandleFunc recibe como path una ruta URL (por ejemplo "/status"). Y como handler una función que cumple con el prototipo de http.HandlerFunc. Es decir, una función con firma func(http.ResponseWriter, \*http.Request). Dado el path, este método guarda el handler/callback asociado.

Esto es exactamente lo que hacen routers como el de gorilla/mux o el http.ServeMux del paquete estándar, solo que nuestra versión es minimalista y sin funcionalidades extras.

¿Por qué es un método y no una función? Porque necesita modificar el campo "rutas" del router concreto sobre el que se llama. Al usar (r \*CustomRouter) como receptor, la función tiene acceso directo al mapa interno del router (es decir, a rutas).

¿Y por qué usamos \*CustomRouter y no solo CustomRouter? Usamos un receptor con puntero para evitar copiar el struct completo en cada llamada y para dejar claro que el método puede modificar el estado interno del router. Aunque los mapas en Go son tipos de referencia, usar un puntero es la convención habitual cuando un método muta el estado del receptor.

Los callback definidos anteriormente pueden registrarse en nuestro router haciendo esto:

```
r.HandleFunc("/", Index)
r.HandleFunc("/status", Status)
```

Poco que explicar aquí. Cada URL tiene un handler asociado, que quedan almacenados dentro del mapa de "rutas".

## Constructor del CustomRouter

Ahora vamos a crear el constructor del router:

```
func NuevoRouter() *CustomRouter {
    return &CustomRouter{
        rutas: make(map[string]http.HandlerFunc),
    }
}
```

El mismo código se podría escribir de forma más legible:

```
func NuevoRouter() *CustomRouter {
    mapaRutas := make(map[string]http.HandlerFunc)

    router := CustomRouter{
        rutas: mapaRutas,
    }

    return &router
}
```

Las dos variantes de NuevoRouter() hacen exactamente lo mismo. Aunque al usar Go es prefiere usar la forma compacta (la primera).

¿Qué hace esta función NuevoRouter(). Esta función crea una nueva instancia de la estructura CustomRouter. No tiene parámetros de entrada, y retorna un puntero a CustomRouter. En el cuerpo de la función se hace un return explicito a una estructura de tipo CustomRouter que inicializa su campo "rutas" con un mapa que tiene como clave elementos de tipo string y como valor un http.HandlerFunc (es decir, callbacks). Se usa make para crear el mapa. Y finalmente se devuelve una referencia (un puntero) al objeto CustomRouter que se acaba de crear.

# Función ListenAndServe

La función [http.ListenAndServe](https://pkg.go.dev/net/http@go1.25.5#ListenAndServe) es una función del paquete estándar de Go "http", que inicia un servidor web. Tiene esta firma:

```
func ListenAndServe(addr string, handler http.Handler) error
```

Como ves, recibe dos argumentos de entrada:

- addr: un string con ip + port, es decir, ":8080", fácil.
- http.Handler: es un tipo que debe cumplir con la interfaz http.Handler.

Esta función abre un puerto de red (ej. :8080), escucha conexiones entrantes, y por cada petición HTTP que llega, llama al handler especificado en el segundo argumento http.Handler. Este handler no es arbitrario. Go necesita que sepa gestionar peticiones HTTP. Para ello, debe cumplir con el interfaz http.Handler, que tiene esta firma:

```
type Handler interface {
    ServeHTTP(ResponseWriter, *Request)
}
```

Esto es una exigencia para cualquier servidor HTTP de Go.

Recuerda que previamente has creado el tipo CustomRouter:

```
type CustomRouter struct {
    rutas map[string]http.HandlerFunc
}
```

Vamos ahora a definir el método ServeHTTP para el tipo \*CustomRouter:

```
func (r *CustomRouter) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    if handler, existe := r.rutas[req.URL.Path]; existe {
        handler(w, req)
    } else {
        http.NotFound(w, req)
    }
}
```

Este método permite que el CustomRouter cumpla con la interfaz http.Handler, requisito obligatorio para poder pasar el CustomRouter a la función ListenAndServe.

Fíjate que este método recibe dos argumentos como entrada:

- http.ResponseWriter: permite escribir la respuesta HTTP (cuerpo, código de estado, headers).
- *http.Request: contiene la petición entrante, incluyendo la URL solicitada.

Este método obtiene el handler de la ruta extraída de req.URL.Path almacenada en el mapa r.rutas. Y si existe ese handler, entonces lo llama pasando como argumentos de entrada w y req para que genere la respuesta. Si no existe el handler, devolvería un error 404 de NotFound.


## Función main

Ahora ya puedes pasar a la función ListenAndServe tu router custom (CustomRouter) como segundo argumento. Si juntas todas las piezas en una sola función main, obtienes este código:

```
func main() {
    // Creamos nuestro router
    r := NuevoRouter()

    // Registramos rutas usando los callback definidos
    r.HandleFunc("/", Index)
    r.HandleFunc("/status", Status)

    // Iniciamos el servidor con NUESTRO router
    println("Servidor escuchando en :8080")
    http.ListenAndServe(":8080", r)
}
```

## Código fuente completo

Finalmente, aquí tenemos el código del router custom:

```
package main

import (
    "net/http"
)

type CustomRouter struct {
    rutas map[string]http.HandlerFunc
}

func NuevoRouter() *Router {
    return &Router{
        rutas: make(map[string]http.HandlerFunc),
    }
}

func (r *Router) HandleFunc(path string, handler http.HandlerFunc) {
    r.rutas[path] = handler
}

func (r *Router) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    if handler, existe := r.rutas[req.URL.Path]; existe {
        handler(w, req)
    } else {
        http.NotFound(w, req)
    }
}

func Index(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("Página principal\n"))
}

func Status(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("OK\n"))
}

func main() {
    r := NuevoRouter()
    r.HandleFunc("/", Index)
    r.HandleFunc("/status", Status)

    println("Servidor escuchando en :8080")
    http.ListenAndServe(":8080", r)
}
```

Ya dispones de todos los componentes en un solo archivo. Solo falta ejecutarlo:

```
$ go run custom-router.go
```

Ahora vez a tu navegador favorito. Y navega a estas URL:

- http://localhost:8080/
- http://localhost:8080/status

Verás en el navegador las respuestas esperadas.

# Despedida

En este artículo has construido un router HTTP funcional desde cero utilizando Go y su librería estándar, con el objetivo de comprender los fundamentos reales del enrutamiento HTTP más allá del uso de frameworks. A partir de una implementación mínima, has visto cómo registrar rutas, asociarlas a handlers y conectar un router propio con el servidor HTTP de Go mediante la interfaz http.Handler.

Este ejercicio pone de manifiesto que el enrutamiento HTTP en Go se apoya en conceptos simples y bien definidos, y que no se trata de una “caja negra”. Entender estas bases permite tomar decisiones arquitectónicas más informadas, evaluar con criterio cuándo merece la pena introducir dependencias externas y escribir código más claro, mantenible y predecible.

A partir de aquí, el siguiente paso natural sería ampliar este router con funcionalidades habituales, como soporte para métodos HTTP (GET, POST, PUT) o parámetros en la URL. Incluso si finalmente se opta por utilizar routers existentes como http.ServeMux, gorilla/mux u otras alternativas más completas, el conocimiento adquirido en este artículo proporciona una base sólida para comprender sus ventajas, limitaciones y costes reales.

Construir un router HTTP desde cero no es un objetivo en sí mismo, sino un excelente ejercicio para afianzar el modelo de servidor de Go y reforzar los fundamentos del desarrollo backend. Ahora entiendes cómo funciona internamente una pieza clave que muchos desarrolladores utilizan a diario sin haberla implementado nunca.

Si este contenido te ha resultado útil, puedes comentarlo por el [canal de Telegram](https://t.me/lateclaescape). Según el interés que muestren las métricas del blog, seguiré publicando artículos similares sobre Go u otros lenguajes de programación. Nos vemos en el próximo articulo.

Pulso la tecla ESC, dos puntos wq!
