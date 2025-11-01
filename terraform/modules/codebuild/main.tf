resource "aws_codebuild_project" "build" {
  name         = var.project_name
  service_role = var.codebuild_service_role_arn

  artifacts { type = "CODEPIPELINE" }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "ECR_REPO_URI"
      value = var.ecr_repo_url
    }
  }

  source {
  type      = "CODEPIPELINE"
  buildspec = file("${path.module}/../../buildspecs/buildspec_build.yml")
}

}

resource "aws_codebuild_project" "deploy" {
  name         = "${var.project_name}-deploy"
  service_role = var.codebuild_service_role_arn

  artifacts { type = "CODEPIPELINE" }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "CLUSTER_NAME"
      value = var.eks_cluster_name
    }

    environment_variable {
      name  = "NAMESPACE"
      value = var.k8s_namespace
    }

    environment_variable {
      name  = "DEPLOYMENT_NAME"
      value = var.k8s_deployment_name
    }

    environment_variable {
      name  = "ECR_URI"
      value = var.ecr_repo_url
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }
  }

  source {
  type      = "CODEPIPELINE"
  buildspec = file("${path.module}/../../buildspecs/buildspec_deploy.yml")
}


}
