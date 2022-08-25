#!/bin/bash

echo '========================================================'
echo '=== PASO 1: INSTALACIÓN DE PREREQUISITOS PARA DOCKER ==='
echo '========================================================'
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
        ca-certificates \
        curl \
        unzip \
        gnupg-agent \
        software-properties-common -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

echo '=============================================================='
echo '=== PASO 2: AGREGAR REPOSITORIO PARA LA INSTALACIÓN DOCKER ==='
echo '=============================================================='
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update

echo '====================================='
echo '=== PASO 3: INSTALACIÓN DE DOCKER ==='
echo '====================================='
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
# Iniciar Docker junto con el Arranque del Sistema Operativo
sudo systemctl enable docker
# Agregar Usuario Actual al Grupo de Docker
sudo usermod -aG docker $USER

echo '============================================='
echo '=== PASO 4: INSTALACIÓN DE DOCKER-COMPOSE ==='
echo '============================================='
sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo '==============================================================='
echo '=== PASO 5: INICIAR DOCKER AL ARRANCAR EL SISTEMA OPERATIVO ==='
echo '==============================================================='
sudo systemctl enable docker

echo '========================================================='
echo '=== PASO 6: AGREGAR USUARIO ACTUAL AL GRUPO DE DOCKER ==='
echo '========================================================='
sudo usermod -aG docker ${USER}

echo '========================================='
echo '=== PASO 7: INSTALAR HERRAMIENTA CTOP ==='
echo '========================================='
echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo apt update
sudo apt install docker-ctop

echo '================================================================'
echo '=== PASO 8: CREAR DIRECTORIOS DE VOLUMENES PARA CONTENEDORES ==='
echo '================================================================'
sudo mkdir -p /storage/volumes/nginx/certs
sudo mkdir -p /storage/volumes/nginx/vhostd
sudo mkdir -p /storage/volumes/nginx/html
sudo mkdir -p /storage/volumes/nginx/config

sudo mkdir -p /storage/volumes/www

sudo mkdir -p /storage/volumes/mongodb/data/node01
sudo mkdir -p /storage/volumes/mongodb/data/node02
sudo mkdir -p /storage/volumes/mongodb/data/node03
sudo mkdir -p /storage/volumes/mongodb/scripts
sudo mkdir -p /storage/volumes/mongodb/key

sudo mkdir -p /storage/volumes/elastic/data/node01
sudo mkdir -p /storage/volumes/elastic/data/node02
sudo mkdir -p /storage/volumes/elastic/data/node03
sudo mkdir -p /storage/volumes/elastic/certs

sudo chmod 777 -R /storage/volumes/elastic/data/node01
sudo chmod 777 -R /storage/volumes/elastic/data/node02
sudo chmod 777 -R /storage/volumes/elastic/data/node03

sudo mkdir -p /storage/volumes/logstash/setup
sudo mkdir -p /storage/volumes/logstash/config

sudo mkdir -p /storage/volumes/kibana/data
sudo chmod 777 -R /storage/volumes/kibana/data

sudo mkdir -p /storage/volumes/monstache

sudo mkdir -p /storage/volumes/netdata/etc

sudo mkdir -p /deploy

echo '===================================='
echo '=== PASO 9: CLONADO REPOSITORIOS ==='
echo '===================================='
cd /storage/volumes/www
sudo git clone https://github.com/StartBootstrap/startbootstrap-sb-admin-2.git

cd /deploy
sudo git clone https://jlrosasp1:glpat-x9jo7dPcdnZSpSRmRzQm@gitlab.com/delasalle/settings.git

cd /deploy/settings
sudo cp ./nginx/settings.conf /storage/volumes/nginx/config
sudo cp ./mongo/mongo-rs-setup.sh /storage/volumes/mongodb/scripts
sudo cp ./monstache/monstache.config.toml /storage/volumes/monstache

echo '==============================================='
echo '=== PASO 10: PRE REQUISITOS MONGODB CLUSTER ==='
echo '==============================================='
sudo openssl rand -base64 756 > /storage/volumes/mongodb/key/security.keyFile
sudo chown 999:999 /storage/volumes/mongodb/key/security.keyFile
sudo chmod 0400 /storage/volumes/mongodb/key/security.keyFile

echo '=============================================='
echo '=== PASO 11: PRE REQUISITOS ELASTIC SEARCH ==='
echo '=============================================='
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sudo sysctl -p

echo '==========================================='
echo '=== PASO 12: DESPLIEGUE DE CONTENEDORES ==='
echo '==========================================='

# echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# sudo apt-get update
# sudo apt-get install -y docker.io 
# sudo apt-get install -y docker-compose
# sudo apt install -y git
# cd /
# rm -R /proyecto/
# sudo mkdir -p /proyecto/peimbert
# cd /proyecto/peimbert
# git clone https://github.com/alangithub2018/proyecto-peimbert.git
# cd /proyecto/peimbert/proyecto-peimbert/Final_Image
# chmod 777 -R /proyecto/

# docker-compose up -d
# cd /proyecto/peimbert/proyecto-peimbert/Final_Image/MongoCluster/
# sleep 5
# chmod a+x rs-init.sh 
# docker exec mongo1 /scripts/rs-init.sh
# cd /proyecto/peimbert/proyecto-peimbert/Final_Image
# docker-compose -f /proyecto/peimbert/proyecto-peimbert/Final_Image/docker-compose-api.yml up -d
# chmod a+x /proyecto/peimbert/proyecto-peimbert/Final_Image/Nginx/init-letsencrypt.sh
# ./proyecto/peimbert/proyecto-peimbert/Final_Image/Nginx/init-letsencrypt.sh
# cd /proyecto/peimbert/proyecto-peimbert/Final_Image/Nginx
# ./init-letsencrypt.sh