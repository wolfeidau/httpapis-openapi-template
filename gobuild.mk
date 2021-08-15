GOLANGCI_VERSION = 1.34.0

LDFLAGS := -ldflags="-s -w -X main.version=${GIT_HASH}_${BUILD_DATE}"

# This path is used to cache binaries used for development and can be overridden to avoid issues with osx vs linux
# binaries.
BIN_DIR ?= $(shell pwd)/bin

$(BIN_DIR)/golangci-lint: $(BIN_DIR)/golangci-lint-${GOLANGCI_VERSION}
	@ln -sf golangci-lint-${GOLANGCI_VERSION} $(BIN_DIR)/golangci-lint
$(BIN_DIR)/golangci-lint-${GOLANGCI_VERSION}:
	@curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | BINARY=golangci-lint bash -s -- v${GOLANGCI_VERSION}
	@mv $(BIN_DIR)/golangci-lint $@

$(BIN_DIR)/mockgen:
	@go get -u github.com/golang/mock/mockgen
	@env GOBIN=$(BIN_DIR) GO111MODULE=on go install github.com/golang/mock/mockgen

$(BIN_DIR)/gosec:
	@go get -u github.com/securego/gosec/v2/cmd/gosec@327b2a0841836d0fce89ef79b3050e7b255dd533
	@env GOBIN=$(BIN_DIR) GO111MODULE=on go install github.com/securego/gosec/v2/cmd/gosec

mocks: $(BIN_DIR)/mockgen
	@echo "--- build all the mocks"
	@bin/mockgen -destination=mocks/session_store.go -package=mocks github.com/dghubble/sessions Store
.PHONY: mocks

init:
	@echo "update the go module name to $(MODULE_PKG)"
	@go mod edit -module $(MODULE_PKG)
.PHONY: init

clean:
	@echo "--- clean all the things"
	@rm -rf ./dist
.PHONY: clean

scanpr: $(BIN_DIR)/gosec
	$(BIN_DIR)/gosec -fmt golint ./...

scan: $(BIN_DIR)/gosec
	$(BIN_DIR)/gosec -fmt sarif ./... > results.sarif

lint: $(BIN_DIR)/golangci-lint
	@echo "--- lint all the things"
	@$(BIN_DIR)/golangci-lint run
.PHONY: lint

lint-fix: $(BIN_DIR)/golangci-lint
	@echo "--- lint all the things"
	@$(BIN_DIR)/golangci-lint run --fix
.PHONY: lint-fix

test:
	@echo "--- test all the things"
	@go test -coverprofile=coverage.txt ./...
	@go tool cover -func=coverage.txt
.PHONY: test

build:
	@echo "--- build all the things"
	@mkdir -p dist
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -trimpath -o dist ./cmd/...
.PHONY: build

archive:
	@echo "--- build an archive"
	@cd dist && zip -X -9 -r ./handler.zip *-lambda
.PHONY: archive