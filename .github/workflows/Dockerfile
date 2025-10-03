2) Agregar el workflow de publish a GHCR

Crea .github/workflows/docker-publish.yml con:

name: Docker Publish

on:

push:

branches: [ main ]

workflow_dispatch: {}

permissions:

contents: read

packages: write

jobs:

build-push:

runs-on: ubuntu-latest

steps:

- uses: actions/checkout@v4
- uses: docker/setup-qemu-action@v3
- uses: docker/setup-buildx-action@v3
- uses: docker/login-action@v3
    
    with:
    
    registry: [ghcr.io](http://ghcr.io)
    
    username: mimave
    
    password: $ secrets.GHCR_TOKEN
    
- uses: docker/build-push-action@v6
    
    with:
    
    context: .
    
    push: true
    
    tags: |
    
    [ghcr.io/mimave/train-tcs:latest](http://ghcr.io/mimave/train-tcs:latest)
    

3) Opcional: CI básico (tests y lint)

Crea .github/workflows/ci.yml con:

name: CI

on:

pull_request:

branches: [ main, develop ]

push:

branches: [ develop ]

jobs:

ci:

runs-on: ubuntu-latest

steps:

- uses: actions/checkout@v4
- uses: actions/setup-python@v5
    
    with:
    
    python-version: "3.11"
    
- run: pip install -U pip pytest ruff
- run: ruff check .
- run: pytest -q

4) Probar

- Haz un commit a main para disparar Docker Publish
- Revisa en GitHub Packages que aparezca [ghcr.io/mimave/train-tcs:latest](http://ghcr.io/mimave/train-tcs:latest)
- docker pull [ghcr.io/mimave/train-tcs:latest](http://ghcr.io/mimave/train-tcs:latest) para validar
