data "aws_iam_policy_document" "deny" {
  statement {
    sid    = "DenyAll"
    effect = "Deny"

    actions   = ["*"]
    resources = ["*"]
  }
}

module "iam_deny" {
  source = "../../"

  name                  = var.name

  force_destroy         = true
  create_iam_access_key = var.create_iam_access_key
  inline_policies       = [data.aws_iam_policy_document.deny.json]
  sm_enabled           = var.sm_enabled
  sm_base_path         = var.sm_base_path

  sm_ses_smtp_password_enabled = var.sm_ses_smtp_password_enabled
}