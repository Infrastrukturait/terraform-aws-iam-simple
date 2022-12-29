output "user_name" {
  value       = module.iam_deny.user_name
  description = "Normalized IAM user name"
}

output "user_arn" {
  value       = module.iam_deny.user_arn
  description = "IAM user ARN"
}

output "user_unique_id" {
  value       = module.iam_deny.user_unique_id
  description = "IAM user unique ID assigned by AWS"
}

output "access_key_id" {
  value       = module.iam_deny.access_key_id
  description = "The access key ID"
}

output "secret_access_key" {
  sensitive   = true
  value       = module.iam_deny.secret_access_key
  description = <<-EOT
When `sm_enabled` is `false`, this is the secret access key for the IAM user.
This will be written to the state file in plain-text.
When `sm_enabled` is `true`, this output will be empty to keep the value secure.
EOT
}

output "ses_smtp_password_v4" {
  sensitive   = true
  value       = module.iam_deny.ses_smtp_password_v4
  description = <<-EOT
When `sm_enabled` is false, this is the secret access key converted into an SES SMTP password
by applying AWS's Sigv4 conversion algorithm. It will be written to the Terraform state file in plaintext.
When `sm_enabled` is `true`, this output will be empty to keep the value secure.
EOT
}

output "access_key_id_sm_path" {
  value       = module.iam_deny.access_key_id_sm_path
  description = "The Secret Manager path under which the IAM User's access key ID is stored"
}

output "secret_access_key_sm_path" {
  value       = module.iam_deny.secret_access_key_sm_path
  description = "The Secret Manager path under which the IAM User's secret access key is stored"
}

output "ses_smtp_password_v4_sm_path" {
  value       = module.iam_deny.ses_smtp_password_v4_sm_path
  description = "The Secret Manager path under which the IAM User's SES SMTP password is stored"
}