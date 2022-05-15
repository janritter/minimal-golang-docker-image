clean:
	rm -rf dist/

build: clean
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/google-caller -ldflags="-w -s -extldflags '-static'" ./...

build-scratch: build
	docker build -f Dockerfile.scratch -t minimal-golang-image:scratch .

build-alpine: build
	docker build -f Dockerfile.alpine -t minimal-golang-image:alpine .

build-distroless: build
	docker build -f Dockerfile.distroless -t minimal-golang-image:distroless .

build-broken: build
	docker build -f Dockerfile.broken -t minimal-golang-image:broken .

list-images:
	docker image ls --filter=reference="minimal-golang-image:*"
