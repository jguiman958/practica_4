#!/bin/bash

# Muestra todos los comandos que se han ejeutado.

set -x

# Actualización de repositorios
 sudo apt update

# Actualización de paquetes
# sudo apt upgrade  

# Instalamos el servidor Web apache

apt install apache2 -y

#instalar mysql server
sudo apt install mysql-server -y

#Instalar php
sudo apt install php libapache2-mod-php php-mysql -y

# Copiar el archivo de configuracion de apache.
sudo cp ../conf/000-default.conf /etc/apache2/sites-available

#Reiniciamos el servicio apache
sudo systemctl restart apache2

# Copiamos el arhivo de prueba de php
sudo cp ../php/index.php /var/www/html

# Modificamos el propietario y el grupo del directo /var/www/html
sudo chown -R www-data:www-data /var/www/html


