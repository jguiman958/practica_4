#!/bin/bash

# Muestra todos los comandos que se han ejeutado.

set -ex

# Actualización de repositorios
 apt update

# Actualización de paquetes
# sudo apt upgrade 

# Importamos el archivo de variables .env
source .env

# Creamos un certificado y una clave privada
openssl req \
  -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /etc/ssl/certs/apache-selfsigned.crt \
  -subj "/C=$OPENSSL_COUNTRY/ST=$OPENSSL_PROVINCE/L=$OPENSSL_LOCALITY/O=$OPENSSL_ORGANIZATION/OU=$OPENSSL_ORGUNIT/CN=$OPENSSL_COMMON_NAME/emailAddress=$OPENSSL_EMAIL"

  # Copiamos el archivo de configuracion de apache para https:
  cp ../conf/default-ssl.conf /etc/apache2/sites-available/

  # Habilitamos el host virtual para https
  a2ensite default-ssl.conf

  # Habilitamos el modulo ssl
  a2enmod ssl

  # Reiniciamos el servicio de apache2
  systemctl restart apache2

  # Configuramos que las peticiones a HTTP se redirigan a https
  # Copiamos el archivo de configuración de VirtualHost para HTTP
  cp ../conf/000-default.conf /etc/apache2/sites-available
   
  # Modificamos el campo del archivo principal default-ssl.conf
  sed -i "s#PUT_YOUR_DOMAIN_HERE#$OPENSSL_COMMON_NAME#" /etc/apache2/sites-available/default-ssl.conf

  # Habilitamos el modulo rewrite
  a2enmod rewrite

  # Reiniciamos el servicio de apache
  systemctl restart apache2
