: ${IMAGE_PREFIX:=}
: ${TAG:=local}
: ${DOCKER_BUILD:=docker build}
echo "Building with IMAGE_PREFIX='${IMAGE_PREFIX}' and TAG='${TAG}'"

cd qmk_base_container
${DOCKER_BUILD} -t ${IMAGE_PREFIX}qmk_base_container:$TAG .

cd ../qmk_cli
docker run --rm \
    -v "$PWD:/work" \
    -w /work \
    ${IMAGE_PREFIX}qmk_base_container:$TAG \
    bash -c "
        pip install --upgrade pip &&
        pip install setuptools wheel build &&
        pip install -r requirements-dev.txt &&
        python3 -m build
    "
sed -i "s|ghcr.io/qmk/qmk_base_container:latest|${IMAGE_PREFIX}qmk_base_container:$TAG|" Dockerfile
${DOCKER_BUILD} -t ${IMAGE_PREFIX}qmk_cli:$TAG -t ${IMAGE_PREFIX}qmk_cli:latest .
