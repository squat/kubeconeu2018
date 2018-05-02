# Terraform version and plugin versions

terraform {
  required_version = ">= 0.10.4"
}

#provider "google" {
  #version = "1.9"

  #credentials = "${file("/path/to/google/cloud/credentials")}"
  #project     = "project-ID"
  #region      = "region"
  #zone        = "zone"
#}

provider "local" {
  version = "~> 1.0"
}

provider "null" {
  version = "~> 1.0"
}

provider "template" {
  version = "~> 1.0"
}

provider "tls" {
  version = "~> 1.0"
}
