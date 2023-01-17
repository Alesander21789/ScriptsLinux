nmap -sS -p- -A -oA nmap-scan target # Escanear todos los puertos, determinar servicios, versiones y sistemas operativos.
nmap -p 80,443 --script http-enum target # Escanear los puertos 80 y 443 y enumerar los recursos HTTP
nmap -p 80,443 --script http-enum --script-args http-enum.url-path-file=paths.txt target # Escanear los puertos 80 y 443 y enumerar los recursos HTTP utilizando un archivo de rutas


nmap --script http-headers target # Escanear puertos HTTP y recopilar información de encabezados
nmap --script http-methods target # Escanear puertos HTTP y determinar los métodos HTTP permitidos
nmap --script http-title target # Escanear puertos HTTP y determinar el título de la página
nmap --script http-robots.txt target # Escanear puertos HTTP y recopilar información de robots.txt
nmap --script http-vuln-cve target # Escanear puertos HTTP y buscar vulnerabilidades conocidas

nmap --script http-phpmyadmin-dir-traversal target # Escanear puertos HTTP y buscar vulnerabilidades de dir-traversal en PHPMyAdmin.
nmap --script http-phpmyadmin-brute target # Escanear puertos HTTP y buscar vulnerabilidades de fuerza bruta en PHPMyAdmin.
nmap --script http-php-version target # Escanear puertos HTTP y determinar la versión de PHP en un sitio web.
nmap --script http-sql-injection target # Escanear puertos HTTP y buscar vulnerabilidades de inyección SQL en un sitio web.

nmap --script http-frontpage-login target # Escanear puertos HTTP y buscar vulnerabilidades de inicio de sesión en FrontPage.
nmap --script http-wordpress-users target # Escanear puertos HTTP y recopilar información de usuarios en un sitio web de WordPress.
nmap --script http-wordpress-enum target # Escanear puertos HTTP y recopilar información de versiones y plugins en un sitio web de WordPress.
nmap --script http-drupal-enum target # Escanear puertos HTTP y recopilar información de versiones y módulos en un sitio web de Drupal.



nmap -sS -p- -A -oA nmap-scan target # Escanear todos los puertos, determinar servicios, versiones y sistemas operativos.
nmap -p 80,443 --script http-enum target # Escanear los puertos 80 y 443 y enumerar los recursos HTTP
nmap -p 80,443 --script http-enum --script-args http-enum.url-path-file=paths.txt target # Escanear los puertos 80 y 443 y enumerar los recursos HTTP utilizando un archivo de rutas
nmap --script http-headers target # Escanear puertos HTTP y recopilar información de encabezados
nmap --script http-methods target # Escanear puertos HTTP y determinar los métodos HTTP permitidos


nmap --script http-title target # Escanear puertos HTTP y determinar el título de la página
nmap --script http-robots.txt target # Escanear puertos HTTP y recopilar información de robots.txt
nmap --script http-vuln-cve target # Escanear puertos HTTP y buscar vulnerabilidades conocidas
nmap --script http-phpmyadmin-dir-traversal target # Escanear puertos HTTP y buscar vulnerabilidades de dir-traversal en PHPMyAdmin.
nmap --script http-phpmyadmin-brute target # Escanear puertos HTTP y buscar vulnerabilidades de fuerza bruta en PHPMyAdmin.



nmap --script http-php-version target # Escanear puertos HTTP y determinar la versión de PHP en un sitio web.
nmap --script http-sql-injection target # Escanear puertos HTTP y buscar vulnerabilidades de inyección SQL en un sitio web.
nmap --script http-frontpage-login target # Escanear puertos HTTP y buscar vulnerabilidades de inicio de sesión en FrontPage.
nmap --script http-wordpress-users target # Escanear puertos HTTP y recopilar información de usuarios en un sitio web de WordPress.
nmap --script http-wordpress-enum target # Escanear puertos HTTP y recopilar información de versiones y plugins en un sitio web de WordPress.



nmap --script http-drupal-enum target # Escanear puertos HTTP y recopilar información de versiones y módulos en un sitio web de Drupal.
nmap -sU -sT -p- --script=banner target # Escanear todos los puertos TCP y UDP y recopilar información de banners
nmap -sS -sV -p- --script=vuln target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades conocidas
nmap -sS -p- --script=smb-enum-shares -oN smb-enum-shares.txt target # Escanear todos los puertos TCP, determinar servicios y versiones, y enumerar recursos compartidos SMB
nmap -sS -p- --script=smb-enum-users -oN smb-enum-users.txt target # Escanear todos los puertos TCP, determinar servicios y versiones, y enumerar usuarios SMB

nmap -sS -sV -p- -oA nmap-scan-all-ports target # Escanear todos los puertos, determinar servicios y versiones
nmap -sU -sT -p- -oA nmap-scan-all-ports-udp target # Escanear todos los puertos TCP y UDP
nmap -sS -p- --script=ftp-anon target # Escanear todos los puertos TCP y buscar servidores FTP anónimos
nmap -sS -p- --script=snmp-info target # Escanear todos los puertos TCP y recopilar información SNMP
nmap -sS -p- --script=smb-os-discovery target # Escanear todos los puertos TCP y determinar los sistemas operativos SMB


nmap -sS -p- --script=nfs-ls target # Escanear todos los puertos TCP y listar recursos NFS
nmap -sS -p- --script=smb-vuln-ms17-010 target # Escanear todos los puertos TCP y buscar vulnerabilidad MS17-010 en SMB
nmap -sS -p- --script=ssl-cert target # Escanear todos los puertos TCP y recopilar información de certificados SSL
nmap -sS -p- --script=ssl-enum-ciphers target # Escanear todos los puertos TCP y enumerar los cifrados SSL permitidos
nmap -sS -p- --script=targets-as target # Escanear todos los puertos TCP y determinar el sistema de autoridad de asignación de direcciones




nmap -sS -sV -p- --script=http-enum target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar directorios comunes en un sitio web.
nmap -sS -sV -p- --script=http-headers target # Escanear todos los puertos TCP, determinar servicios y versiones, y recopilar información de encabezados HTTP
nmap -sS -sV -p- --script=http-methods target # Escanear todos los puertos TCP, determinar servicios y versiones, y verificar los métodos HTTP permitidos
nmap -sS -sV -p- --script=http-trace target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades TRACE en HTTP
nmap -sS -sV -p- --script=http-put target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades PUT en HTTP


nmap -sS -sV -p- --script=http-form-brute target # Escanear todos los puertos TCP, determinar servicios y versiones, y realizar un fuerza bruta en formularios HTTP
nmap -sS -sV -p- --script=http-vuln-cve target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades conocidas en HTTP
nmap -sS -sV -p- --script=http-webdav-scan target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar recursos WEBDAV
nmap -sS -sV -p- --script=http-iis-webdav-vuln target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades WEBDAV en IIS
nmap -sS -sV -p- --script=http-vuln-wp-plugins target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades en plugins de WordPress



nmap -sS -sV -p- --script=http-vuln-lfi target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades LFI en HTTP
nmap -sS -sV -p- --script=http-vuln-rfi target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades RFI en HTTP
nmap -sS -sV -p- --script=http-vuln-xss target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades XSS en HTTP
nmap -sS -sV -p- --script=http-vuln-sqli target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades SQLi en HTTP
nmap -sS -sV -p- --script=http-vuln-csrf target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades CSRF en HTTP


# Nmap ping scan
$ sudo nmap –sn -oA nmap_pingscan 192.168.100.0/24 (-PE)

# Nmap SYN/Top 100 ports Scan
$ nmap -sS -F -oA nmap_fastscan 192.168.0.1/24

# Nmap SYN/Version All port Scan - ## Main Scan
$ sudo nmap -sV -PN -p0- -T4 -A --stats-every 60s --reason -oA nmap_scan 192.168.0.1/24

# Nmap SYN/Version No Ping All port Scan
$ sudo nmap -sV -Pn -p0- --exclude 192.168.0.1 --reason -oA nmap_scan 192.168.0.1/24

# Nmap UDP All port scan - ## Main Scan
$ sudo nmap -sU -p0- --reason --stats-every 60s --max-rtt-timeout=50ms --max-retries=1 -oA nmap_scan 192.168.0.1/24

# Nmap UDP/Fast Scan
$ nmap -F -sU -oA nmap_UDPscan 192.168.0.1/24

# Nmap Top 1000 port UDP Scan
$ nmap -sU -oA nmap_UDPscan 192.168.0.1/24

# Nmap enumerate SSL ciphers on remote host/port
$ nmap -Pn -p 5986 --script=ssl-enum-ciphers <TARGET>

# HPING3 Scans
$ hping3 -c 3 -s 53 -p 80 -S 192.168.0.1
# Open = flags = SA
# Closed = Flags = RA
# Blocked = ICMP unreachable
# Dropped = No response

# Source port scanning
$ nmap -g <port> (88 (Kerberos) port 53 (DNS) or 67 (DHCP))
# Source port also doesn't work for OS detection.

# Speed settings:
# -n                Disable DNS resolution 
# -sS               TCP SYN (Stealth) Scan 
# -Pn               Disable host discovery
# -T5               Insane time template
# --min-rate 1000   1000 packets per second
# --max-retries 0   Disable retransmission of timed-out probes




nmap -sS -sV -p- --script=http-vuln-* target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades conocidas en HTTP
nmap -sS -sV -p- --script=vuln target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades conocidas
nmap -sS -sV -p- --script=all target # Escanear todos los puertos TCP, determinar servicios y versiones, y ejecutar todos los scripts
nmap -sS -sV -p- --script-args=vulscandetail=1 --script=vuln target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades conocidas con detalles adicionales


nmap -sS -sV --script=http-vhosts target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar host virtuales HTTP
nmap -sS -sV --script=http-devframework target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar frameworks de desarrollo web
nmap -sS -sV --script=http-config-backup target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar archivos de configuración de respaldo
nmap -sS -sV --script=http-git target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar repositorios git expuestos
nmap -sS -sV --script=http-fileupload-exploiter target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades de subida de archivos



nmap -sS -sV --script=http-frontpage-login target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar páginas de inicio de FrontPage expuestas
nmap -sS -sV --script=http-phpmyadmin-dir-traversal target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades de traversal de directorios en PHPMyAdmin
nmap -sS -sV --script=http-phpmyadmin-vuln target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades conocidas en PHPMyAdmin
nmap -sS -sV --script=http-robots.txt target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar robots.txt
nmap -sS -sV --script=http-shellshock target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades Shellshock


nmap -sS -sV -p- --script=http-enum target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar páginas y archivos existentes en el servidor web
nmap -sS -sV -p- --script=http-headers target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar información de encabezados HTTP
nmap -sS -sV -p- --script=http-trace target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar TRACE/TRACK métodos habilitados
nmap -sS -sV -p- --script=http-methods target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar métodos HTTP permitidos
nmap -sS -sV -p- --script=http-passwd target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar archivos de contraseñas protegidos por HTTP



nmap -sS -sV -p- --script=http-put target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar la posibilidad de subir archivos mediante el método PUT
nmap -sS -sV -p- --script=http-iis-webdav-vuln target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades de WebDAV en servidores IIS
nmap -sS -sV -p- --script=http-webdav-scan target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar la presencia de WebDAV
nmap -sS -sV -p- --script=http-joomla-brute target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar Joomla vulnerabilidades de fuerza bruta
nmap -sS -sV -p- --script=http-wp-enum target # Escanear todos los puertos TCP, determinar servicios y versiones, y buscar vulnerabilidades de WordPress

