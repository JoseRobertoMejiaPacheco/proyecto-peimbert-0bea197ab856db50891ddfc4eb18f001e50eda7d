 rm -R /proyecto
 mkdir /proyecto
 cd /proyecto/
 git clone https://github.com/JoseRobertoMejiaPacheco/proyecto-peimbert-0bea197ab856db50891ddfc4eb18f001e50eda7d.git .
 git checkout GC
 cd MongoCluster/
 ./dbstart.sh 
 cd ..
 cd ApiMongoDB/
 docker-compose up -d
 cd ..
 cd Odoo15/
 docker-compose up -d
 cd ..
 cd Nginx/
 ./init-letsencrypt.sh
