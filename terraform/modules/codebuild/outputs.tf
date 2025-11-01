output "build_project_name" { value = aws_codebuild_project.build.name }
output "build_project_arn"  { value = aws_codebuild_project.build.arn  }

output "deploy_project_name" { value = aws_codebuild_project.deploy.name }
output "deploy_project_arn"  { value = aws_codebuild_project.deploy.arn  }
