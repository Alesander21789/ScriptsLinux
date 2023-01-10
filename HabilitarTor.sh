# Actualizar los repositorios e instalar Tor y Proxychains
sudo apt-get update
sudo apt-get install tor proxychains -y

# Configurar Proxychains para utilizar Tor
echo "socks5 127.0.0.1 9050" | sudo tee -a /etc/proxychains.conf

# Habilitar el servicio de Tor para iniciar automáticamente con el sistema
sudo systemctl enable tor

# Iniciar el servicio de Tor
sudo systemctl start tor

# Verificar el estado del servicio de Tor
sudo systemctl status tor
