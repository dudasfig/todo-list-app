terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Seu cluster EKS já existe, então vamos buscar ele
data "aws_eks_cluster" "cluster" {
  name = "eksDeepDiveFrankfurt"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "eksDeepDiveFrankfurt"
}

provider "kubernetes" {
  host = data.aws_eks_cluster.cluster.endpoint

  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.cluster.certificate_authority[0].data
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--region", var.aws_region,
      "--cluster-name", "eksDeepDiveFrankfurt"
    ]
  }
}
