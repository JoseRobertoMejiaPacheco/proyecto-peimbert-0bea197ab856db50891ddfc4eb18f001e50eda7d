###########################Install docker##########################
###################################################################

sudo apt-get update \ install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg 
--dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) 
signed-by=/etc/apt/keyrings/docker.gpg] 
https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee 
/etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io 
docker-compose-plugin

###########################Install docker################################
#########################################################################

###########################Install docker compose #######################
#########################################################################

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

###########################Install docker compose #######################
#########################################################################

####################################Install ctop#########################
#########################################################################

sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64  -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop

####################################Install ctop#########################
#########################################################################

#################Install elasticsearch  #################################
#########################################################################

sysctl -w vm.max_map_count=262144
docker network create elastic
docker pull docker.elastic.co/elasticsearch/elasticsearch:8.3.3
docker run --name es-node01 --net elastic -p 9200:9200 -p 9300:9300 -t docker.elastic.co/elasticsearch/elasticsearch:8.3.3

#################Install elasticsearch  #################################
#########################################################################

# take a break here and open another terminal because you`ll need 
# enrollment token for kibana here

#################Install Kibana  ########################################
#########################################################################

docker pull docker.elastic.co/kibana/kibana:8.3.3
docker run --name kib-01 --net elastic -p 5601:5601 docker.elastic.co/kibana/kibana:8.3.3