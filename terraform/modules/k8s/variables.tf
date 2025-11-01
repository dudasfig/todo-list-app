variable "region" {}
variable "todo_replicas" {
  default = 1
}
variable "todo_image" {
  default = "325583868777.dkr.ecr.eu-central-1.amazonaws.com/esf-vppm/todo-list:latest"
}