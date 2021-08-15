default: clean build archive package deploy-api
.PHONY: default

# include project information / configuration
include project.mk

# include generic build steps for linting, building and testing go projects 
include gobuild.mk

deploy: build archive package deploy-api
.PHONY: deploy

ci: clean lint test
.PHONY: ci

package:
	@echo "--- uploading cloudformation assets to $(S3_BUCKET)"
	@sam package \
		--template-file sam/backend/api.yaml \
		--output-template-file dist/api.out.yaml \
		--s3-bucket $(DEPLOY_BUCKET) \
		--s3-prefix sam/$(APPNAME)/$(STAGE)/$(BRANCH)/$(GIT_HASH)
.PHONY: package

deploy-api:
	@echo "--- deploy stack $(APPNAME)-$(STAGE)-$(BRANCH)"
	@sam deploy \
		--no-fail-on-empty-changeset \
		--template-file dist/api.out.yaml \
		--capabilities CAPABILITY_IAM \
		--tags "environment=$(STAGE)" "branch=$(BRANCH)" "service=$(APPNAME)" \
		--stack-name $(APPNAME)-$(STAGE)-$(BRANCH) \
		--parameter-overrides AppName=$(APPNAME) Stage=$(STAGE) Branch=$(BRANCH)
.PHONY: deploy-api

apilogs:
	sam logs --stack-name $(APPNAME)-$(STAGE)-$(BRANCH) --name APIFunction --tail
.PHONY: apilogs
