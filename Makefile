.PHONY: build sync clean

default: build sync

build:
	sh -e -x build-docker.sh

sync:
	git submodule sync --recursive
	git submodule update --init --recursive

clean:
	git submodule foreach --recursive git reset --hard
	sudo git submodule foreach --recursive git clean -fdx
