output "pipeline"       { value = module.pipeline.pipeline_name }
output "build_project"  { value = module.codebuild.build_project_name }
output "deploy_project" { value = module.codebuild.deploy_project_name }
output "ecr_repo"       { value = try(module.ecr.repository_url, var.ecr_repo_url) }
