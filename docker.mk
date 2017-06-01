# Author: umur.ozkul@gmail.com
# Returns container id given a service name
CONTAINER_ID=$(shell docker ps | grep $(1) | tr -s ' ' | cut -d' ' -f1)

## ACCESSING A SERVICE

# make attach-<service name>
.PHONY: docker-attach-service-%
docker-attach-service-%:
	docker attach --sig-proxy=false $(call CONTAINER_ID, $*)

# make bash-<service name>
.PHONY: docker-bash-service-%
docker-bash-service-%:
	docker exec -it $(call CONTAINER_ID, $*) bash

## DEPLOYING A SERVICE

# make docker-deploy-<env>
.PHONY: deploy-env-%
docker-deploy-env-%: docker/docker-compose-%.yml
	docker stack deploy -c $< $@

## BUILDING A SERVICE

# make docker/docker-compose-<env>.ytml
#   Build compose file for an <env>
docker/docker-compose-%.yml: docker/template-docker-compose.yml
	. docker/$*.env.sh && \
	envsubst < docker/template-docker-compose.yml \
	| sed '/#NO_$*/d' > $@

.PHONY: docker-compose-files
docker-compose-files: docker/docker-compose-local.yml docker/docker-compose-prod.yml docker/docker-compose-dev.yml

# make docker-build-local-image-<image>
#   Only local image is built here. The other images are tagged versions of it.
docker-build-env-%: docker/docker-compose-%.yml docker-release.tar
	docker build -t $(IMAGE_NAME):local .

# REMOVE DOCKER GARBAGE
.PHONY: docker-clean docker-clean-containers docker-clean-images

docker-clean: docker-clean-containers docker-clean-images

docker-clean-containers:
	- docker rm $(shell docker ps --no-trunc -aq)

docker-clean-images:
	- docker rmi $(shell docker images -f dangling=true -q) -f
