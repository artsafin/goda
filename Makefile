UIDGID=$(shell id -u):$(shell id -g)

all: update

update:
	curl -s https://coda.io/apis/v1/openapi.yaml | sed -e 's/\bSortBy\b/SortBySchema/g' > openapi.yaml
	rm -v *.gen.go || true
	docker run --rm \
		-u "$(UIDGID)" \
		-v "$(PWD):/src" \
		ghcr.io/artsafin/docker-oapi-codegen -generate types,skip-prune,client -package goda -o api.gen.go openapi.yaml
	docker run --rm \
		-v "$(PWD):/src" \
		-w "/src" \
		golang:1.14-alpine go build -v
