terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.42.0"
    }
  }

   cloud {
    organization = "aws-amit"

    workspaces {
      name = "amit-aws-firewall-poc"
    }
}

}
