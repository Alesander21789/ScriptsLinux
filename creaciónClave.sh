#!/bin/bash

# Crear carpeta para almacenar las claves
mkdir -p ~/Alesander\ Martinez\ Seijo

# Crear clave privada
openssl genpkey -algorithm RSA -out ~/Alesander\ Martinez\ Seijo/private.pem -aes256

# Crear clave pública a partir de la privada
openssl rsa -in ~/Alesander\ Martinez\ Seijo/private.pem -outform PEM -pubout -out ~/Alesander\ Martinez\ Seijo/public.pem

# Crear certificado utilizando la clave pública
openssl req -new -x509 -key ~/Alesander\ Martinez\ Seijo/private.pem -out ~/Alesander\ Martinez\ Seijo/cert.pem
