#!/bin/bash

# Verificar si el usuario es root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Establecer el idioma a español
sudo update-locale LANG=es_ES.UTF-8

# Establecer la distribución de teclado a español
sudo localectl set-keymap es

# Establecer el formato de fecha y hora a español
sudo timedatectl set-timezone Europe/Madrid
sudo timedatectl set-locale "es_ES.UTF-8"

# Reiniciar el sistema para que los cambios surtan efecto
echo "The changes will take effect after restarting the system"
sudo reboot