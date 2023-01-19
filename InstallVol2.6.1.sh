#!/bin/bash

echo "Actualizando lista de paquetes..."
sudo apt update -y 2>/dev/null | progressbar

echo "Instalando paquetes necesarios..."
sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata 2>/dev/null | progressbar

echo "Instalando Python 2 y librerías necesarias..."
sudo apt install -y python2 python2.7-dev libpython2-dev curl 2>/dev/null | progressbar

echo "Descargando pip..."
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py 2>/dev/null

echo "Instalando pip..."
sudo python2 get-pip.py 2>/dev/null | progressbar

echo "Actualizando setuptools y wheel..."
sudo python2 -m pip install -U setuptools wheel 2>/dev/null | progressbar

echo "Instalando paquetes de python..."
python2 -m pip install -U distorm3 yara pycrypto pillow openpyxl ujson pytz ipython capstone 2>/dev/null | progressbar

echo "Instalando yara de nuevo..."
sudo python2 -m pip install yara 2>/dev/null | progressbar

echo "Creando enlace simbólico para libyara..."
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so 2>/dev/null

echo "Agregando Volatility al PATH..."
export PATH="$PATH:/path/to/volatility"

echo "¡Listo! Todos los paquetes han sido instalados correctamente y Volatility ha sido agregado al PATH."
