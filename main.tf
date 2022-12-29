locals {
  username              = aws_iam_user.this.name

  inline_policies_map   = merge(
    var.inline_policies_map,
    { for i in var.inline_policies : md5(i) => i }
  )

  policy_arns_map       = merge(
    var.policy_arns_map,
    { for i in var.policy_arns : i => i }
  )

  key_id_sm_path        = "${trimsuffix(var.sm_base_path, "/")}/${local.username}/access_key_id"
  secret_sm_path        = "${trimsuffix(var.sm_base_path, "/")}/${local.username}/secret_access_key"
  smtp_password_sm_path = "${trimsuffix(var.sm_base_path, "/")}/${local.username}/ses_smtp_password_v4"
}

resource "aws_iam_user" "this" {
  name                 = var.name
  path                 = var.path
  force_destroy        = var.force_destroy
  tags                 = var.tags
  permissions_boundary = var.permissions_boundary
}

resource "aws_iam_access_key" "this" {
  count = var.create_iam_access_key ? 1 : 0
  user  = local.username
}

resource "aws_iam_user_policy" "this" {
  for_each = local.inline_policies_map
  lifecycle {
    create_before_destroy = true
  }
  user        = local.username
  policy      = each.value
}

resource "aws_iam_user_policy_attachment" "this" {
  for_each = local.policy_arns_map
  lifecycle {
    create_before_destroy = true
  }
  user       = local.username
  policy_arn = each.value
}

module "secret_iam_access_key" {
  source  = "Infrastrukturait/secret-manager/aws"
  version = "0.1.0"

  count       = var.sm_enabled ? 1 : 0

  name        = local.key_id_sm_path
  value       = aws_iam_access_key.this[0].id
  description = "The AWS_ACCESS_KEY_ID for the ${local.username} user."
  tags        = var.tags
}

module "secret_iam_private_key" {
  source  = "Infrastrukturait/secret-manager/aws"
  version = "0.1.0"

  count       = var.sm_enabled ? 1 : 0

  name        = local.secret_sm_path
  value       = aws_iam_access_key.this[0].secret
  description = "The AWS_SECRET_ACCESS_KEY for the ${local.username} user."
  tags        = var.tags
}

module "secret_ses_smtp_password" {
  source  = "Infrastrukturait/secret-manager/aws"
  version = "0.1.0"

  count       = var.sm_enabled ? (var.sm_ses_smtp_password_enabled ? 1 : 0) : 0

  name        = local.smtp_password_sm_path
  value       = aws_iam_access_key.this[0].ses_smtp_password_v4
  description = "The AWS_SECRET_ACCESS_KEY converted into an SES SMTP password for the ${local.username} user."
  tags        = var.tags
}
