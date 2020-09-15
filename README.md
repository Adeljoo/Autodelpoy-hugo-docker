# Hugo-docker-script
This Dockerfile is used to dockerized hugo wesite and a script to update the running image in a server based on the content of a github. This dicker can use for non-root users. After building the image and push it to your server, you can test the generated website by updating files in your website content repository, then see the changes in your website. The script runs in the background checks for the assigen repository every 20s and if there is a new push then will update the website.

To build, run and push the image: 
```
DOCKER_REPO_URL=your-docker-repo
VERSION:=versionnumber
tagname=site

secrets.GIT_TOKEN=(git personal token)
image=$(DOCKER_REPO_URL)/$(tagname):$(VERSION)

help:
	@echo "build - build the  image"
	@echo "run   - run the image in local docker"
	@echo "push  - push the  image to jfrog"
	@echo "show  - show the current make variables"

build:
	docker build -t $(tagname) .
	docker tag  $(tagname) $(image)
run:
	docker run -it -p 1313:1313  -e GIT_TOKEN=$(secrets.GIT_TOKEN) $(image) 
run-local:
	docker run -it -p 1313:1313  -e GIT_TOKEN=$(secrets.GIT_TOKEN) --entrypoint /bin/bash $(image)
push:
	
	docker push $(image)
show:
	@echo "make file configuration"
	@echo "URL:" $(DOCKER_REPO_URL)
	@echo "version:" $(VERSION)
	@publish=$(DOCKER_REPO_URL)/$(image)
	@echo "tagname:" $(tagname)
  
  ```
