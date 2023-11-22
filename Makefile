
# Definitions
#############
export PROJECT_NAME=symfony_graphql_youtube

DOCKER_EXEC=docker exec $(PROJECT_NAME)_php bash -c
PHPSTAN_LVL=8


# Run tests
###########
test: test_phpstan test_phpcs test_phpunit test_phpunit_e2e test_phpunit_integration test_infection

test_pre_push: test_phpstan test_phpcs test_phpunit test_phpunit_integration test_phpunit_e2e

test_phpstan:
	$(DOCKER_EXEC) "vendor/bin/phpstan analyse --configuration=./settings/phpstan.neon --level=$(PHPSTAN_LVL)"

test_phpcs:
	$(DOCKER_EXEC) "vendor/bin/phpcs --standard=./settings/phpcs.xml src/ tests/"

test_phpunit:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --testsuite unit"

test_phpunit_integration:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --testsuite integration --no-coverage"

test_phpunit_integration_filter:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --testsuite integration --no-coverage --filter=${filter}"

test_phpunit_e2e:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --testsuite edge-to-edge --no-coverage"

test_phpunit_e2e_manually:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --testsuite edge-to-edge-manually --no-coverage"

test_phpunit_e2e_manually_filter:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --testsuite edge-to-edge-manually --no-coverage --filter=${filter}"

test_phpunit_e2e_filter:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --testsuite edge-to-edge --no-coverage --filter=${filter}"

test_phpunit_coverage_filter:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --colors=always --coverage-text --filter=${filter}"

test_phpunit_coverage:
	$(DOCKER_EXEC) "vendor/bin/phpunit -c ./settings --colors=always --coverage-text --testsuite unit"

test_infection:
	$(DOCKER_EXEC) "vendor/bin/infection --configuration=./settings/infection.json5 --threads=max --only-covered"

test_infection_filter:
	$(DOCKER_EXEC) "vendor/bin/infection --configuration=./settings/infection.json5 --threads=max --filter=${filter}"


# Symfony commands
##################
cacheclear:
	$(DOCKER_EXEC) "rm -f var/log/php_error.log"
	$(DOCKER_EXEC) "php bin/console cache:clear"

create_component:
	$(DOCKER_EXEC) "php bin/console generate:component --componentName=${componentName}"

profiler:
	open http://localhost:8080/_profiler


# Fix code style
#################
fix_unused_imports:
	$(DOCKER_EXEC) "vendor/bin/php-cs-fixer fix src/ --rules=no_unused_imports"
	$(DOCKER_EXEC) "vendor/bin/php-cs-fixer fix tests/ --rules=no_unused_imports"

phpcbf:
	$(DOCKER_EXEC) "vendor/bin/phpcbf --standard=./settings/phpcs.xml src/ tests/"

phpstan_generate_baseline:
	$(DOCKER_EXEC) "vendor/bin/phpstan analyse --configuration=./settings/phpstan.neon --level=$(PHPSTAN_LVL) --generate-baseline"


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


# Git commits
#############
git_commit_feat: __git_commit_check_args
	git add -A
	git-cz --non-interactive --disable-emoji --type=feat --subject="$(subject)" --breaking="$(breaking)"

git_commit_fix: __git_commit_check_args
	git add -A
	git-cz --non-interactive --disable-emoji --type=fix --subject="$(subject)" --breaking="$(breaking)"

git_commit_test: __git_commit_check_args
	git add -A
	git-cz --non-interactive --disable-emoji --type=test --subject="$(subject)" --breaking="$(breaking)"

git_commit_refactor: __git_commit_check_args
	git add -A
	git-cz --non-interactive --disable-emoji --type=refactor --subject="$(subject)" --breaking="$(breaking)"

__git_commit_check_args:
ifndef subject
	$(error subject is undefined)
endif
