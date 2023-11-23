
# Definitions
#############
export PROJECT_NAME=symfony_graphql_youtube

DOCKER_EXEC=docker exec $(PROJECT_NAME)_php bash -c

# Symfony commands
##################
cacheclear:
	$(DOCKER_EXEC) "rm -f var/log/php_error.log"
	$(DOCKER_EXEC) "php bin/console cache:clear"

# Dependency management
#######################
composer_install:
	$(DOCKER_EXEC) "composer install --no-interaction --optimize-autoloader"

composer_update:
	$(DOCKER_EXEC) "composer update --no-interaction --optimize-autoloader"

composer_require:
	$(DOCKER_EXEC) "composer require ${packageInfo}"


# Container management
######################
container_run: container_build container_up composer_install cacheclear

container_up:
	docker compose -p $(PROJECT_NAME) -f ./container/docker-compose.yml up -d

container_down:
	docker compose -p $(PROJECT_NAME) -f ./container/docker-compose.yml down

container_reup: container_down container_up

container_build:
	docker compose -p $(PROJECT_NAME) -f ./container/docker-compose.yml build

container_rebuild:
	docker compose -p $(PROJECT_NAME) -f ./container/docker-compose.yml build --no-cache

container_bash:
	docker exec -it $(PROJECT_NAME)_php bash

container_logs:
	docker logs --follow $(PROJECT_NAME)_php
