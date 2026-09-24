# AWS Key Pair Terraform Module

A simple Terraform module to create an AWS Key Pair. 
This module follows Terraform best practices by separating variables, outputs, and resources.

## Usage

You can use either a direct public key string or the path to a public key file.

### Example using a public key string
```hcl
module "key_pair" {
  source = "./modules/KEY_Pair"

  key_name   = "my-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD..."
  
  tags = {
    Environment = "Dev"
    Project     = "Infrastructure"
  }
}
```

### Example using a public key path
```hcl
module "key_pair" {
  source = "./modules/KEY_Pair"

  key_name        = "my-key-pair"
  public_key_path = "~/.ssh/id_rsa.pub"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key_name | The name for the key pair | `string` | n/a | yes |
| public_key | The public key material | `string` | `null` | no |
| public_key_path | Path to the public key file | `string` | `null` | no |
| tags | A map of tags to add to the resource | `map(string)` | `{}` | no |

*Note: You must provide either `public_key` or `public_key_path`.*
