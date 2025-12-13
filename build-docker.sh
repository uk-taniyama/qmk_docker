tag=1.1.8
cd qmk_base_container
docker build -t qmk_base_container:$tag .
cd ../qmk_cli
docker run --rm -it \
    -v "$PWD:/work" \
    -w /work \
    qmk_base_container:$tag \
    bash -c "
        pip install --upgrade pip &&
        pip install setuptools wheel build &&
        pip install -r requirements-dev.txt &&
        python3 -m build
    "
sed -i "s|ghcr.io/qmk/qmk_base_container:latest|qmk_base_container:$tag|" Dockerfile
docker build -t qmk_cli:$tag .
docker build -t qmk_cli:latest .
docker build -t qmk_cli:local .
git reset --hard
