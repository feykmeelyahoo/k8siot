VERSION=1.0.971
PROJECT=10.151.17.110/edbys
APP=kyportal-serkan

build:
	docker build --pull -t ${PROJECT}/${APP}:${VERSION} -t ${PROJECT}/${APP}:latest .

push: build
	docker push ${PROJECT}/${APP}:${VERSION}
	docker push ${PROJECT}/${APP}:latest