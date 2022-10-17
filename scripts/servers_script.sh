### Download essential resources on hostvm ###
cd /vagrantshared
rm -rf /vagrantshared/*
git clone https://github.com/youfuyfyf/3204-coursework-1
chmod -R 755 3204-coursework-1

### Docker Compose ###
cd /vagrantshared/3204-coursework-1/git_resources/dockerfiles/
docker compose up -d

### Check Container Status ###
docker ps
