# Choose an project name
PROJECT = picosite
# Your Docker username
USERNAME := luebken

default:
	echo There is no default target.\n 
	echo Please get familiar with the Makefile and use the appropriate targets.
	echo e.g. "make prepare && make build && make install"

prepare:
	ln -s $(PWD) $(shell helm home)/workspace/charts/$(PROJECT)

build:
	docker build -t $(USERNAME)/$(PROJECT) image/
	docker push $(USERNAME)/$(PROJECT)

install:
	helm install $(PROJECT)

install-without-helm:
	kubectl create -f manifests/picosite-rc.yml
	kubectl create -f manifests/picosite-svc.yml

clean:
	rm $(shell helm home)/workspace/charts/$(PROJECT)