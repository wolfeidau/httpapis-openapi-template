APPNAME := httpapis-openapi-template
STAGE ?= dev
BRANCH ?= master
SAR_VERSION ?= 1.0.0
MODULE_PKG := github.com/wolfeidau/httpapis-openapi-template

GIT_HASH := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date -u '+%Y%m%dT%H%M%S')