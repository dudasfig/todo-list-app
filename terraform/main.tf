locals {
  artifacts_bucket = "${var.project_name}-artifacts"
}

module "ecr" {
  source           = "./modules/ecr"
  repository_name  = "${var.project_name}"
}

module "k8s" {
  source     = "./modules/k8s"

  # variáveis exigidas pelo módulo
  todo_image = "325583868777.dkr.ecr.eu-central-1.amazonaws.com/esf-vppm/todo-list:latest"
  region     = var.aws_region                  
}


module "codebuild" {
  source                     = "./modules/codebuild"
  project_name               = var.project_name
  codebuild_service_role_arn = "arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role"
  aws_region                 = var.aws_region
  ecr_repo_url               = module.ecr.ecr_repo_url

  eks_cluster_name     = "eksDeepDiveFrankfurt"     # <<-- EKS EXISTENTE
  k8s_namespace        = "default"               # <<-- escolha um nome SEU
  k8s_deployment_name  = "esf-vppm-eu-central-1-deployment-todo"           # <<-- nome do seu deploy
  k8s_container_name   = "todo"                # <<-- nome do container dentro do deploy
}


module "pipeline" {
  source                     = "./modules/codepipeline"
  project_name               = var.project_name
  aws_region                 = var.aws_region

  artifacts_bucket_name      = local.artifacts_bucket

  codestar_connection_arn    = var.codestar_connection_arn
  github_full_repo_id        = var.github_full_repo_id
  github_branch              = var.github_branch

  build_project_name         = module.codebuild.build_project_name
  build_project_arn          = module.codebuild.build_project_arn
  deploy_project_name        = module.codebuild.deploy_project_name
  deploy_project_arn         = module.codebuild.deploy_project_arn

  codebuild_service_role_arn = var.codebuild_service_role_arn
}
