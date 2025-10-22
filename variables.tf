variable "admin_password" {
  description = "Administrator password for the VM. Should be stored in GitHub Secrets and passed via TF_VAR_admin_password"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.admin_password) >= 8
    error_message = "Admin password must be at least 8 characters long."
  }
}
