build:
	echo "building version $(VERSION)"
	sed -i .tmp 's/VERSION=dev/VERSION=$(VERSION)/' Dockerfile
	docker build . -t giefferre/k8s-test:$(VERSION)
	rm Dockerfile && mv Dockerfile.tmp Dockerfile

push:
	echo "pushing version $(VERSION)"
	docker push giefferre/k8s-test:$(VERSION)

run:
	kubectl create namespace test || echo "namespace already exists"
	sed -i .tmp 's/:dev/:$(VERSION)/' manifests/deploy.yaml
	sed -i .tmp 's/:dev/:$(VERSION)/' manifests/service.yaml
	kubectl create --namespace test -f manifests
	rm manifests/deploy.yaml && mv manifests/deploy.yaml.tmp manifests/deploy.yaml
	rm manifests/service.yaml && mv manifests/service.yaml.tmp manifests/service.yaml

stop:
	kubectl --namespace test delete -f manifests

build-and-push: build push