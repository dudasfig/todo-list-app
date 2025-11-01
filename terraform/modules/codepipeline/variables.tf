variable "project_name"               { type = string }
variable "aws_region"                 { type = string }

variable "artifacts_bucket_name"      { type = string }

variable "codestar_connection_arn"    { type = string }
variable "github_full_repo_id"        { type = string }
variable "github_branch"              { type = string }

variable "build_project_name"         { type = string }
variable "build_project_arn"          { type = string }
variable "deploy_project_name"        { type = string }
variable "deploy_project_arn"         { type = string }

variable "codebuild_service_role_arn" { type = string }
