variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "project_name" {
  type    = string
  default = "esf-vppm-todo-list"
}

# conexão GitHub já existente (CodeStar Connections)
variable "codestar_connection_arn" {
  type = string
}

# repositório GitHub (owner/repo)
variable "github_full_repo_id" {
  type    = string
  default = "dudasfig/todo-list-app"
}

variable "github_branch" {
  type    = string
  default = "main"
}

# role OBRIGATÓRIA do laboratório para CodeBuild
variable "codebuild_service_role_arn" {
  type    = string
  default = "arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role"
}

# se quiser que o Terraform crie o ECR, use o módulo e ignore isso;
# se já tem ECR pronto, passe a URL aqui (ex.: 3255...eu-central-1.amazonaws.com/esf-vppm/todo-list)
variable "ecr_repo_url" {
  type    = string
  default = null
}

variable "eks_cluster_name" {
  type = string
}

variable "k8s_namespace" {
  type    = string
  default = "default"
}

variable "k8s_deployment_name" {
  type    = string
  default = "esf-vppm-eu-central-1-deployment-todo"
}

variable "k8s_container_name" {
  type    = string
  default = "todo"
}

variable "ecs_cluster_name" {
  description = "ECS-esf-vppm"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS-esf-vppm-service"
  type        = string
}


