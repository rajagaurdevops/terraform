variable "key_name" {
  description = "The name for the key pair."
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file (e.g., '~/.ssh/id_rsa.pub')."
  type        = string
  default     = null
}

variable "public_key" {
  description = "The public key material. If not provided, it will use the public_key_path."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to the key pair resource."
  type        = map(string)
  default     = {}
}
