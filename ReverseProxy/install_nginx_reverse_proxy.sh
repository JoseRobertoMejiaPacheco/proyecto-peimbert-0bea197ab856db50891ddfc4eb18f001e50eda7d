#Modificar el archivo web.conf para agregar los subdominios registrados en Cpanel u otro

sudo mkdir -p /proyecto/peimbert
sudo chmod 777 -R /proyecto/peimbert
cd /proyecto/peimbert
git clone https://github.com/JoseRobertoMejiaPacheco/nginx-certboot.git
cd /proyecto/peimbert/nginx-certboot
chmod a+x init-letsencrypt.sh
sudo ./init-letsencrypt.sh