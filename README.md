# httpapis-openapi-template

This project provides a template for a Go based REST API hosted in AWS Lambda using API Gatway HTTPAPIs.

# Deployment

Update the `project.mk` file with `APPNAME` and `MODULE_PKG` used for your project.

```
make init
```

Create an .envrc file using [direnv](https://direnv.net/).

```bash
#!/bin/bash

export AWS_PROFILE=wolfeidau
export AWS_DEFAULT_PROFILE=wolfeidau
export AWS_REGION=ap-southeast-2
export DEPLOY_BUCKET=cf-abc123-ap-southeast-2
```

To deploy the stack run.

```
make
```

Your now ready to hit the API :tada:

### Fork It And Make Your Own

You can fork this repo to create your own boilerplate.