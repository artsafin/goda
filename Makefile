UIDGID=$(shell id -u):$(shell id -g)

all: update

update:
	curl -s https://coda.io/apis/v1/openapi.yaml | sed -e 's/\bSortBy\b/SortBySchema/g' > openapi.yaml
	docker run --rm \
		-u "$(UIDGID)" \
		-v "$(PWD):/src" \
		ghcr.io/artsafin/docker-oapi-codegen -generate types -package goda -o types.gen.go openapi.yaml
	docker run --rm \
		-u "$(UIDGID)" \
		-v "$(PWD):/src" \
		ghcr.io/artsafin/docker-oapi-codegen -generate client -package goda -o client.gen.go openapi.yaml
	docker run --rm \
		-v "$(PWD):/src" \
		-w "/src" \
		golang:1.14-alpine go build -v
