NAME ?= mottainai-agent
PACKAGE_NAME ?= $(NAME)
PACKAGE_CONFLICT ?= $(PACKAGE_NAME)-beta
REVISION := $(shell git rev-parse --short HEAD || echo unknown)
VERSION := $(shell git describe --tags || echo $(REVISION) || echo dev)
VERSION := $(shell echo $(VERSION) | sed -e 's/^v//g')
ITTERATION := $(shell date +%s)
BUILD_PLATFORMS ?= -osarch="linux/amd64" -osarch="linux/386" -osarch="linux/arm" -osarch="linux/arm64"
EXTENSIONS ?= lxd
all: deps build

help:
	# make all => deps test lint build
	# make deps - install all dependencies
	# make test - run project tests
	# make lint - check project code style
	# make build - build project for all supported OSes

clean:
	rm -rf vendor/
	rm -rf release/

deps:
	go env
	# Installing dependencies...
	go get golang.org/x/lint/golint
	go get github.com/mitchellh/gox
	go get golang.org/x/tools/cmd/cover
	go get github.com/mattn/goveralls

multiarch-build:
	CGO_ENABLED=0 gox $(BUILD_PLATFORMS) -tags $(EXTENSIONS) -output="release/$(NAME)-$(VERSION)-{{.OS}}-{{.Arch}}" -ldflags "-extldflags=-Wl,--allow-multiple-definition"
ifeq ($(EXTENSIONS),)
	CGO_ENABLED=0 gox $(BUILD_PLATFORMS) -tags $(EXTENSIONS) -output="release/$(NAME)-$(VERSION)-{{.OS}}-{{.Arch}}" -ldflags "-extldflags=-Wl,--allow-multiple-definition"
#		CC="arm-linux-gnueabi-gcc" LD_LIBRARY_PATH=/usr/arm-linux-gnueabi/lib gox -osarch="linux/arm" -output="release/$(NAME)-$(VERSION)-{{.OS}}-{{.Arch}}" -ldflags "-extldflags=-Wl,--allow-multiple-definition"
else
	CGO_ENABLED=0 gox $(BUILD_PLATFORMS) -output="release/$(NAME)-$(VERSION)-{{.OS}}-{{.Arch}}" -ldflags "-extldflags=-Wl,--allow-multiple-definition"
#		CC="arm-linux-gnueabi-gcc" LD_LIBRARY_PATH=/usr/arm-linux-gnueabi/lib gox -tags $(EXTENSIONS) -osarch="linux/arm" -output="release/$(NAME)-$(VERSION)-{{.OS}}-{{.Arch}}" -ldflags "-extldflags=-Wl,--allow-multiple-definition" -parallel 1 -cgo
endif

build:
ifeq ($(EXTENSIONS),)
		CGO_ENABLED=0 go build
else
		CGO_ENABLED=0 go build -tags $(EXTENSIONS)
endif

lint:
	# Checking project code style...
	golint ./... | grep -v "be unexported"

test:
	# Running tests... ${TOTEST}
	go test -cover

build-and-deploy:
	make build BUILD_PLATFORMS="-os=linux -arch=amd64"
