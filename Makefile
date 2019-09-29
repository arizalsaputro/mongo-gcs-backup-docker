BINARY=api

DOCKER_IMAGE_NAME=arizalsaputro/mongo-gce-backup

docker-build: ## Build Docker image
	docker build -t ${DOCKER_IMAGE_NAME} .

docker-push: ## Push Docker image to registry
	docker push ${DOCKER_IMAGE_NAME}