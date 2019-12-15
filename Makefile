BASEURL_DEV=http://localhost:8080
BASEURL_PROD=https://wesj.app

REPOSITORY=docker-registry.wesj.app
VERSION=latest
CONTAINER=blog

IMAGE_NAME=${REPOSITORY}/${CONTAINER}:${VERSION}

server:
	hugo server -D
	

blog-draft:
	hugo -D -b ${BASEURL_DEV}

image-draft: blog-draft
	docker build . -t ${IMAGE_NAME}-draft

run-draft: image-draft
	docker run -p 8080:80 --rm ${IMAGE_NAME}-draft


blog:
	hugo -b ${BASEURL_PROD}

image: blog
	docker build . -t ${IMAGE_NAME}

push: image
	docker push ${IMAGE_NAME}

deploy: push
	kubectl apply -f blog.k8s.yml