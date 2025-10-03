Makefile en la raíz

Makefile

.PHONY: build run push scan clean

IMAGE=[ghcr.io/mimave/train-tcs](http://ghcr.io/mimave/train-tcs)

build:

docker build -t $(IMAGE):dev .

run:

docker run --rm $(IMAGE):dev

push:

docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE):latest --push .

scan:

docker pull $(IMAGE):latest || true

docker run --rm -v $$PWD:/src aquasec/trivy:latest image --severity CRITICAL,HIGH --format table $(IMAGE):latest

clean:

docker rmi -f $(IMAGE):dev || true

2) Badges para tu [README.md](http://README.md)

Añade estas líneas al principio:

3) Tip para versionar con tags

- En Actions, ejecuta “Release” e ingresa v0.1.0
- Se construirá además [ghcr.io/mimave/train-tcs:v0.1.0](http://ghcr.io/mimave/train-tcs:v0.1.0)

Si “Docker Publish” falla

- 401/denied: confirma que docker-publish.yml usa secrets.GHCR_TOKEN y que el secreto tiene write:packages y repo
- Dockerfile no encontrado: asegúrate que está en la raíz y que el workflow tiene context: .
- Multi-arch error: cambia temporalmente platforms a linux/amd64 y vuelve a correr
