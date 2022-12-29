variable "region" {
  type        = string
  description = "AWS Region."
}

variable "name" {
  type        = string
  description = "Name of the created user."
}

variable "create_iam_access_key" {
  type        = bool
  description = "Whether or not to create IAM access keys"
}

variable "sm_enabled" {
  type        = bool
  description = "Set `true` to store secrets in AWS Secret Manager"
}

variable "sm_base_path" {
  type        = string
  default     = "/system_user/"
  description = "The base path for AWS Secret Manager parameters where secrets are stored"
}

variable "sm_ses_smtp_password_enabled" {
  type        = bool
  description = "Whether or not to create an SES SMTP password"
  default     = false
}
