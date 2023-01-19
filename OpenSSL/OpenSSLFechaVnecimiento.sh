#!/bin/bash

# Verifica la fecha de vencimiento de un certificado PEM

if [ $# -eq 0 ]; then
  echo "Error: debe especificar el nombre del archivo del certificado PEM"
  exit 1
fi

cert_file=$1

# Usa openssl para verificar la fecha de vencimiento del certificado
expiration_date=$(openssl x509 -enddate -noout -in $cert_file)

# Extrae la fecha de vencimiento del certificado
expiration_date=${expiration_date#*=}

# Muestra la fecha de vencimiento en formato legible
echo "Fecha de vencimiento del certificado: $expiration_date"