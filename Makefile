#===============================================================================
# Default User Options
#===============================================================================

# Build-time arguments
CMAKE_VERSION ?= 3.16.5
LLVM_VERSION  ?= 9.0.1

# Spack variants
LLVM_OPTIONS  ?= ""

# Image name
DOCKER_IMAGE ?= leavesask/llvm
DOCKER_TAG   := $(LLVM_VERSION)

#===============================================================================
# Variables and objects
#===============================================================================

BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
VCS_URL=$(shell git config --get remote.origin.url)

# Get the latest commit
GIT_COMMIT = $(strip $(shell git rev-parse --short HEAD))

#===============================================================================
# Targets to Build
#===============================================================================

.PHONY : docker_build docker_push output

default: build
build: docker_build output
release: docker_build docker_push output

docker_build:
	# Build Docker image
	docker build \
                 --build-arg CMAKE_VERSION=$(CMAKE_VERSION) \
                 --build-arg LLVM_VERSION=$(LLVM_VERSION) \
                 --build-arg LLVM_OPTIONS=$(LLVM_OPTIONS) \
                 --build-arg BUILD_DATE=$(BUILD_DATE) \
                 --build-arg VCS_URL=$(VCS_URL) \
                 --build-arg VCS_REF=$(GIT_COMMIT) \
                 -t $(DOCKER_IMAGE):$(DOCKER_TAG) .

docker_push:
	# Tag image as latest
	docker tag $(DOCKER_IMAGE):$(DOCKER_TAG) $(DOCKER_IMAGE):latest

	# Push to DockerHub
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
	docker push $(DOCKER_IMAGE):latest

output:
	@echo Docker Image: $(DOCKER_IMAGE):$(DOCKER_TAG)
