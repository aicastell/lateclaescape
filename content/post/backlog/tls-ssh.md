---
title: SSL y TLS
date: 2023-12-27
image: /img/posts/la-tecla-esc.jpg
categories: ["criptografia"]
tags: ["asimetrica", "firma digital", "fingerprint"]
draft: true
featured: true
---



Aunque las firmas digitales no proporcionan confidencialidad, se pueden combinar con otros mecanismos de cifrado para garantizar que solo las partes autorizadas puedan acceder a la información transmitida. Since public-key algorithms tend to be much slower than symmetric-key algorithms, modern systems such as TLS and SSH use a combination of the two: one party receives the other’s public key, and ASYM_ENCRYPTs a small piece of data (either a symmetric key or some data us ed to generate it). The remainder of the conversation uses a (typically faster) symmetric-key algorithm for ASYM_ENCRYPTion.·




