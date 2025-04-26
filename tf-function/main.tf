locals {
  value = "HELLO WORLD!"
}

variable "string_list" {
    type = list(string)
    default = ["ser1", "ser2", "ser3"]
}

output "output" {
    value = lower(local.value)
  
}

output "fullname" {
  value = join(" ", ["raja", "kumar"])
}

output "shout" {
  value = upper("hello")
}

