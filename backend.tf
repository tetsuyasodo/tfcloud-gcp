terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "elasticacademy"
 
    workspaces {
      name = "tfcloud-gcp"
    }
  }
}
