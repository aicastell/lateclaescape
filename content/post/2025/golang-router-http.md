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

Un router HTTP es un componente de software que recibe una petición HTTP (con su URL y método) y decide qué función (handler) debe ejecutar para responderla. Es como el repartidor de correo de tu aplicación web: mira la dirección (la URL), y entrega el paquete (la petición) al destinatario correcto (tu función Index, Contact, etc.).

El objetivo de este articulo es desarrollar un código en Go que registre dos rutas distintas "/" y "/status" y que conteste con una respuesta custom para cada una. Queremos este código:

```
r := CustomRouter()
r.HandleFunc("/", Index)
r.HandleFunc("/status", Status)
http.ListenAndServe(":8080", r)
```

# Estructura básica

Definimos una estructura llamada CustomRouter, de esta manera:

```
$ cat custom-router.go
package main

import "net/http"

type CustomRouter struct {
    ...
}
```

# El mapa de rutas

Necesitas un mapa para guardar las rutas y sus handlers asociados. Definimos este mapa dentro de la estructura CustomRouter:

```
$ cat custom-router.go
package main

import "net/http"

type CustomRouter struct {
    rutas map[string]http.HandlerFunc
}
```

El tipo CustomRouter guarda un mapa llamado "rutas" que almacena:

- como clave, un string
- como valor, un tipo http.HandlerFunc.

# El tipo http.HandlerFunc

Seguro que ahora te estas preguntando que demonios es un [http.HandlerFunc](https://pkg.go.dev/net/http@go1.25.5#HandlerFunc). Se trata de un tipo definido dentro del paquete estándar "http", cuya documentación oficial define de esta manera:

```
type HandlerFunc func(ResponseWriter, *Request)
```

Es decir, "HandlerFunc" no es mas que un alias para una función que recibe como argumentos un [http.ResponseWriter](https://pkg.go.dev/net/http#ResponseWriter) y un puntero a [http.Request](https://pkg.go.dev/net/http#Request). Cualquier función que tenga esta firma puede actuar como handler HTTP dentro del ecosistema de Go. Precisamente este es el contrato que exige nuestro router custom para poder registrar funciones asociadas a distintas rutas.

## Lista de Handlers

Con esto claro, ya podemos implementar los handlers que usaremos en el router. A continuación definimos dos funciones que cumplen exactamente con la firma de http.HandlerFunc y que, por tanto, pueden registrarse directamente como callbacks:

```
func Index(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("Página principal\n"))
}

func Status(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("Página de estado\n"))
}
```

Cada una de estas funciones será responsable de generar la respuesta HTTP para una ruta concreta. Más adelante las asociaremos a distintas URLs mediante el router, cerrando así el círculo entre la definición del tipo http.HandlerFunc y su uso práctico en la aplicación.

# Registro de rutas

Ahora vamos a implementar un método del tipo \*CustomRouter. Este método permite registrar un handler (una función callback que maneja peticiones HTTP) para una ruta específica.

```
func (r *CustomRouter) HandleFunc(path string, handler http.HandlerFunc) {
    r.rutas[path] = handler
}
```

Esta función HandleFunc recibe dos argumentos:

- un path, es decir, una ruta URL (por ejemplo "/status").
- un handler que cumple con el prototipo http.HandlerFunc que hemos definido antes.

Dado el path, este método guarda el handler/callback asociado en el mapa "rutas".

Esto es exactamente lo que hacen routers como el de gorilla/mux o el http.ServeMux del paquete estándar, solo que nuestra versión es minimalista y sin funcionalidades extras.

¿Por qué es un método y no una función? Porque necesita modificar el campo "rutas" del router concreto sobre el que se llama. Al usar (r \*CustomRouter) como receptor, la función tiene acceso directo al mapa interno del router (es decir, a rutas).

¿Y por qué usamos \*CustomRouter y no solo CustomRouter? Usamos un receptor con puntero para evitar copiar el struct completo en cada llamada y para dejar claro que el método puede modificar el estado interno del router. Aunque los mapas en Go son tipos de referencia, usar un puntero es la convención habitual cuando un método muta el estado del receptor.

Los callback definidos anteriormente pueden registrarse en nuestro router haciendo esto:

```
r.HandleFunc("/", Index)
r.HandleFunc("/status", Status)
```

# Constructor del CustomRouter

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

Esta función abre un puerto de red (ej. :8080), escucha conexiones entrantes, y por cada petición HTTP que llega, llama al handler especificado en el segundo argumento http.Handler. Este handler no es arbitrario. Go necesita un handler que sepa gestionar peticiones HTTP. Y para ello, debe implementar el interfaz [http.Handler](https://pkg.go.dev/net/http#Handler), que tiene esta firma:

```
type Handler interface {
    ServeHTTP(ResponseWriter, *Request)
}
```

Esto no es opcional. Es una exigencia para cualquier servidor HTTP de Go.

Recuerda que previamente has creado el tipo CustomRouter:

```
type CustomRouter struct {
    rutas map[string]http.HandlerFunc
}
```

Vamos ahora a implementar el método ServeHTTP para el tipo \*CustomRouter, es decir, para nuestro router custom:

```
func (r *CustomRouter) ServeHTTP(w http.ResponseWriter, req *http.Request) {
    if handler, existe := r.rutas[req.URL.Path]; existe {
        handler(w, req)
    } else {
        http.NotFound(w, req)
    }
}
```

La implementación del método ServeHTTP es la que permite que el CustomRouter cumpla con la interfaz http.Handler, requisito obligatorio para poder pasar el CustomRouter a la función ListenAndServe. Fijate que ServeHTTP recibe dos argumentos como entrada:

- http.ResponseWriter: permite escribir la respuesta HTTP (cuerpo, código de estado, headers).
- \*http.Request: contiene la petición entrante, incluyendo la URL solicitada.

El método obtiene del mapa r.rutas el handler asociado a la ruta extraída de req.URL.Path. Si existe ese handler, entonces lo llama pasando como argumentos de entrada w y req para que genere la respuesta. Si no existe el handler, devolvería un error 404 de NotFound.

# Función main

Ahora ya puedes pasar a la función ListenAndServe tu router custom (CustomRouter) como segundo argumento. Juntando todas las piezas en una sola función main, obtienes este código:

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

# Código fuente completo

Finalmente, aquí tenemos el código del router custom:

```
$ cat custom-router.go
package main

import (
    "net/http"
)

type CustomRouter struct {
    rutas map[string]http.HandlerFunc
}

func NuevoRouter() *CustomRouter {
    return &CustomRouter{
        rutas: make(map[string]http.HandlerFunc),
    }
}

func (r *CustomRouter) HandleFunc(path string, handler http.HandlerFunc) {
    r.rutas[path] = handler
}

func (r *CustomRouter) ServeHTTP(w http.ResponseWriter, req *http.Request) {
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

Ahora ves a tu navegador favorito, y entra en estas URL:

- http://localhost:8080/
- http://localhost:8080/status

Verás en el navegador las respuestas esperadas.

# Despedida

En este artículo has construido un router HTTP funcional desde cero utilizando Go y su librería estándar, con el objetivo de comprender los fundamentos del enrutamiento HTTP más allá del uso de frameworks. Partiendo de una implementación mínima, has visto cómo registrar rutas, asociarlas a handlers y conectar un router propio con el servidor HTTP de Go mediante la interfaz http.Handler.

Este ejercicio demuestra que el enrutamiento HTTP en Go se basa en conceptos simples y bien definidos, lejos de ser una “caja negra”. Comprender estas bases permite tomar mejores decisiones arquitectónicas, evaluar cuándo introducir dependencias externas y escribir código más claro y mantenible.

El siguiente paso natural sería ampliar el router con funcionalidades habituales, como soporte para métodos HTTP o parámetros en la URL. Incluso utilizando routers existentes como http.ServeMux, gorilla/mux u otras alternativas más completas, el conocimiento adquirido aquí proporciona una base sólida para entender sus ventajas, limitaciones y costes reales.

Construir un router HTTP desde cero no es un objetivo en sí mismo, sino un excelente ejercicio para afianzar el modelo de servidor de Go y reforzar los fundamentos del desarrollo backend. Ahora entiendes cómo funciona internamente una pieza clave que muchos desarrolladores utilizan a diario sin haberla implementado nunca.

Si este contenido te ha resultado útil, te ha despertado alguna duda, quieres ver más artículos sobre Go o simplemente te apetece pasarte a saludar, puedes hacerlo por el [canal de Telegram](https://t.me/lateclaescape). Estoy al otro lado de la tecla ESC para lo que necesites. ¡Nos vemos en el próximo articulo!.

Pulso la tecla `ESC:wq!`
