terraform {

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }

  required_version = "~> 1.3"
}

