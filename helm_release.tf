provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.dev-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.dev-cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.dev-cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"

  values = [
    "${file("jenkins-values.yaml")}"
  ]

  set_sensitive {
    name  = "controller.adminUser"
    value = "admin"
  }
  set_sensitive {
    name = "controller.adminPassword"
    value = "P@55w0rd"
  }
  set_sensitive {
    name = "adminPassword"
    value = "P@55w0rd"
  }
}

resource "helm_release" "awx" {
  name       = "adwerx"
  repository = "https://adwerx.github.io/charts"
  chart      = "awx"

  values = [
    "${file("awx-values.yaml")}"
  ]

  set_sensitive {
    name  = "secretKey"
    value = "P@55w0rd"
  }
  set_sensitive {
    name = "secret_key"
    value = "P@55w0rd"
  }
  set_sensitive {
    name = "defaultAdminUser"
    value = "admin"
  }
  set_sensitive {
    name = "default_admin_user"
    value = "admin"
  }
  set_sensitive {
    name = "defaultAdminPassword"
    value = "P@55word"
  }
  set_sensitive {
    name = "default_admin_password"
    value = "P@55w0rd"
  }
  set_sensitive {
    name = "postgresql.postgresqlUsername"
    value = "awx"
  }
  set_sensitive {
    name = "postgresql.postgresqlPassword"
    value = "P@55word"
  }
}