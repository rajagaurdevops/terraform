terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner  # Your GitHub username or organization
}

resource "github_repository" "my_repo" {
  name        = "my-terraform-repo"
  description = "This repo was created via Terraform 😎"
  visibility  = "public"  # or "private"
  auto_init   = true      # creates README.md
}
