.PHONY: help
.DEFAULT_GOAL := help

help: ## Displays this help message.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: start
start: ## Launch Rails and related services
	bin/dev

.PHONY: check
check: ## Test if the rails app is up
	curl -I localhost:3000

.PHONY: test
test: ## Run unit tests.
	bundle exec rails test

.PHONY: migrate
migrate: ## Run rails migrations
	bundle exec rails db:migrate

.PHONY: seed
seed: ## Run populate database with default data
	bundle exec rails db:seed

.PHONY: console
console: ## Start the rails console
	bundle exec rails console

.PHONY: deploy
deploy: ## Deploy the app 'production' environment
	bundle exec cap production deploy

