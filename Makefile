ALL:
	git submodule sync --recursive
	git submodule update --init --recursive
	sh build-docker.sh

