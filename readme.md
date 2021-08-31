# RYU Infrastracture

This repository contains RYU infrastructure as code, as well as all necessary helm charts and values.

### Instructions

Create `.env` file from `sample.env` and fill in secrets.
Run `source .env` to load secrets.

##### Init terraform
```
terraform init \
-backend-config="access_key=$SPACES_ACCESS_KEY" \
-backend-config="secret_key=$SPACES_SECRET_KEY"
```