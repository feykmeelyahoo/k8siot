VERSION=3.4.740
PROJECT=10.151.17.110/edbys
APP=hvlcm-serkan

build:
	# docker build --pull -t ${PROJECT}/${APP}:${VERSION} -t ${PROJECT}/${APP}:latest .
	docker build -t ${PROJECT}/${APP}:${VERSION} -t ${PROJECT}/${APP}:latest .

push: build
	docker push ${PROJECT}/${APP}:${VERSION}
	docker push ${PROJECT}/${APP}:latest