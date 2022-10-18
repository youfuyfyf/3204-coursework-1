### Download essential resources on hostvm ###
cd /vagrantshared
rm -rf /vagrantshared/*
git clone https://github.com/youfuyfyf/3204-coursework-1
chmod -R 755 /vagrantshared/*

### Docker Compose ###
cd /vagrantshared/3204-coursework-1/dockerfiles/

docker compose up -d

docker container exec -d boss service ssh start
docker container exec -d web service php8.1-fpm start
docker container exec -d web service nginx start

### Check Container Status ###
docker ps
