VERSION=dev.3307
PROJECT=10.151.17.110/edbys
APP=edbysvs-serkan

build:
	docker build --pull -t ${PROJECT}/${APP}:${VERSION} -t ${PROJECT}/${APP}:latest .

push: build
	docker push ${PROJECT}/${APP}:${VERSION}
	docker push ${PROJECT}/${APP}:latest