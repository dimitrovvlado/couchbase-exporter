NAME ?= prometheus-couchbase-exporter
IMAGE ?= vdimitrov/$(NAME)

IMAGES  := $(shell find . -name 'Dockerfile' | cut -d/ -f 2,3 | sed -e 's/\//-/g')
BUILD_TARGS = $(patsubst %,build_%,$(IMAGES))
PUSH_TARGS = $(patsubst %,push_%,$(IMAGES))

.PHONY: all build push $(IMAGES) $(BUILD_TARGS) $(PUSH_TARGS)

build_%:
	docker build -f $(shell echo "$*/Dockerfile" | sed -e "s/build_//" | sed -e "s/push_//" | sed -e "s/-/\//") -t $(IMAGE):$(shell echo "$*" | sed -e "s/^build_//" | sed -e "s/^push_//") .

push_%: build_%
	docker push $(IMAGE):$(shell echo "$*" | sed -e "s/^push_//")

all: push

build: $(addprefix build_,$(BUILD_TARGS))
push: $(addprefix push_,$(PUSH_TARGS))
