terraform {
  backend "http" {
    address  = "https://gitlab.com/api/v4/projects/6309/terraform/state/${var.env}"
    username = var.gitlab-username
    password = var.gitlab-access-token
  }
}
