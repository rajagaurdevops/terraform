variable "github_token" {
  type        = string
  description = "GitHub personal access token"
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "GitHub username or organization name"
}
