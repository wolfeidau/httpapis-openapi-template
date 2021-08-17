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

### Fork It And Make Your Own

You can fork this repo to create your own boilerplate.