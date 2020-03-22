BASEURL_DEV=http://localhost:8080
BASEURL_PROD=https://wesj.org

REPOSITORY=docker-registry.wesj.app
NAMESPACE=applications
DEPLOYMENT=blog

VERSION=`date '+%Y.%m.%d.%H%M'`
CONTAINER=blog

IMAGE_NAME=${REPOSITORY}/${CONTAINER}

server:
	hugo server -D
	

blog-draft:
	hugo -D -b ${BASEURL_DEV}

image-draft: blog-draft
	docker build . -t ${IMAGE_NAME}:draft

run-draft: image-draft
	docker run -p 8080:80 --rm ${IMAGE_NAME}:draft


blog:
	hugo -b ${BASEURL_PROD}

image: blog
	docker build . -t ${IMAGE_NAME}:${VERSION} -t ${IMAGE_NAME}:latest

push: image
	docker push ${IMAGE_NAME}

deploy: push
	kubectl -n ${NAMESPACE} set image deployment/${DEPLOYMENT} ${CONTAINER}=${IMAGE_NAME}:${VERSION} --record

init: push
	kubectl apply -f blog.k8s.yml