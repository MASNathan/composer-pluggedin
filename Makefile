VERSION         := $(shell version)
NEXT_VERSION    := $(shell version increment 0.0.1)
PROJECT_NAME		:= "masnathan/composer-pluggedin"
CONTAINER_NAME	:= "composer"

.PHONY: build
build:
	- docker image rm $(PROJECT_NAME):$(VERSION) --force
	- docker image rm $(PROJECT_NAME):$(NEXT_VERSION) --force
	docker build -t $(PROJECT_NAME):$(NEXT_VERSION) .
	docker tag $(PROJECT_NAME):$(NEXT_VERSION) $(PROJECT_NAME):latest

.PHONY: deploy
deploy: build
	- docker rm -f $(CONTAINER_NAME)
	docker run --name=$(CONTAINER_NAME) -it -d --dns=1.1.1.1 --dns=1.0.0.1 $(PROJECT_NAME):$(NEXT_VERSION)

.PHONY: push
push: tag build
	docker push $(PROJECT_NAME):$(NEXT_VERSION)
	docker push $(PROJECT_NAME):latest

.PHONY: tag
tag:
	git tag $(NEXT_VERSION)
	git push --tags
