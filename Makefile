# Build Docker (One time thing)
docker-build:
	@echo Building Jenkins docker
	./startJenkins.sh

# Start Docker
docker-start:
	@echo Starting docker
	docker-compose up -d

# Stop Services
docker-stop:
	@echo Stoping docker services
	docker-compose stop

# Stop and Remove containers, network, images and volumes
docker-remove:
	@echo Removing Docker Container, Network, Images and Volumes
	docker-compose down
