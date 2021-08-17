# httpapis-openapi-template

This project provides a template for a Go based REST API hosted in AWS Lambda using API Gatway HTTPAPIs.

# Prerequisites

* [Go](https://golang.org)
* AWS Credentials configured in your environment, [configure your AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
* [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)

# Deployment

Update the `project.mk` file with `APPNAME` and `MODULE_PKG` used for your project.

```
make update-module
```

Create an .envrc file using [direnv](https://direnv.net/).

```bash
#!/bin/bash

export AWS_PROFILE=wolfeidau
export AWS_DEFAULT_PROFILE=wolfeidau
export AWS_REGION=ap-southeast-2
export DEPLOY_BUCKET=cf-templates-abc123-ap-southeast-2
```

To deploy the stack run.

```
make
```

Your now ready to hit the API :tada:

# FAQ

Where are my cloudformation templates?

[api.yaml](sam/backend/api.yaml)

Where is the openapi spec?

[api.yaml](openapi/api.yaml)

Where is the lambda main function?

[main.go](cmd/api-lambda/main.go)

Whats is with the `**-lambda` convention for binaries?

Anything in cmd is compiled into a binary, those ending with `-lambda` are bundled into the `handler.zip` uploaded to AWS for deployment in cloudformation.

What is the lambda extras module you include and use in these lambdas?

Have a read of the https://github.com/wolfeidau/lambda-go-extras README and take a look at the references and examples.

### Fork It And Make Your Own

You can fork this repo to create your own boilerplate.