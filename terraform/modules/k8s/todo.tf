
resource "kubernetes_deployment" "todo" {
  metadata {
    name      = "esf-vppm-${var.region}-deployment-todo"
    namespace = "default"
    labels = {
      app     = "todo"
      Aluno   = "hcp"
      Aluno2  = "los2"
      Periodo = "8"
    }
  }
  spec {
    replicas = var.todo_replicas
    selector {
      match_labels = { app = "todo" }
    }
    template {
      metadata { labels = { app = "todo" } }
      spec {
        container {
          name  = "todo"
          image = var.todo_image
          port { container_port = 3000 }
          resources {
            limits   = { cpu = "250m", memory = "256Mi" }
            requests = { cpu = "100m", memory = "128Mi" }
          }
        }
      }
    }
  }

}

resource "kubernetes_service" "todo" {
  metadata {
    name      = "esf-vppm-${var.region}-service-todo"
    namespace = "default"
    
  }
  spec {
    selector = { app = kubernetes_deployment.todo.metadata[0].labels.app }
    port {
      port        = 80
      target_port = 3000
      protocol    = "TCP"
    }
    type = "LoadBalancer"
  }
}
