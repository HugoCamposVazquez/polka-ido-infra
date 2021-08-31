provider "digitalocean" {
  token = var.do_token
}

# Remote state
terraform {
  backend "s3" {
    endpoint = "ams3.digitaloceanspaces.com"
    region   = "us-west-1" # not used since it's a DigitalOcean spaces bucket
    key      = "terraform.tfstate"
    bucket   = "ryu-tf-state"

    skip_requesting_account_id  = true
    skip_get_ec2_platforms      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

# module "staging" {
#   source = "./staging"
# }