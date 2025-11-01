variable "project_name"               { type = string }
variable "aws_region"                 { type = string }
variable "codebuild_service_role_arn" { type = string }
variable "ecr_repo_url"               { type = string }

variable "eks_cluster_name"           { type = string }
variable "k8s_namespace"              { type = string }
variable "k8s_deployment_name"        { type = string }
variable "k8s_container_name"         { type = string }

