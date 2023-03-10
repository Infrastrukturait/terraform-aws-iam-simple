
# terraform-aws-iam-simple

[![WeSupportUkraine](https://raw.githubusercontent.com/Infrastrukturait/WeSupportUkraine/main/banner.svg)](https://github.com/Infrastrukturait/WeSupportUkraine)
## About
Terraform Module to provision a basic IAM user suitable for CI/CD Systems or systems which are *external*
to AWS that cannot leverage [AWS IAM Instance Profiles](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)
or [AWS OIDC](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html).
By default, IAM users, groups, and roles have no access to AWS resources.
IAM policies are the means by which privileges are granted to users, groups, or roles.
It is recommended that IAM policies be applied directly to groups and roles but not users.
**This module intentionally attaches an IAM policy directly to the user and does not use groups**
If an AWS Access Key is created, it is stored either in [AWS Secret Manager](https://aws.amazon.com/secrets-manager/) or is provided as a module output, but not both.
Using [AWS Secret Manager](https://aws.amazon.com/secrets-manager/) is recommended because module outputs are stored in plaintext in the Terraform state file.
[AWS Secret Manager](https://aws.amazon.com/secrets-manager/) is provisioning by [external module](https://registry.terraform.io/modules/Infrastrukturait/secret-manager/aws/latest).
## License

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

```text
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
## Authors
- Rafa?? Masiarek | [website](https://masiarek.pl) | [email](mailto:rafal@masiarek.pl) | [github](https://github.com/rafalmasiarek)
<!-- BEGIN_TF_DOCS -->
## Documentation


### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.48.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret_iam"></a> [secret\_iam](#module\_secret\_iam) | Infrastrukturait/secret-manager/aws | 0.2.0 |

### Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_iam_access_key"></a> [create\_iam\_access\_key](#input\_create\_iam\_access\_key) | Whether or not to create IAM access keys. | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Destroy the user even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. | `bool` | `false` | no |
| <a name="input_inline_policies"></a> [inline\_policies](#input\_inline\_policies) | Inline policies to attach to our created user. | `list(string)` | `[]` | no |
| <a name="input_inline_policies_map"></a> [inline\_policies\_map](#input\_inline\_policies\_map) | Inline policies to attach (descriptive key => policy). | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the created user. | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the user. | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | Permissions Boundary ARN to attach to our created user. | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | Policy ARNs to attach to our created user. | `list(string)` | `[]` | no |
| <a name="input_policy_arns_map"></a> [policy\_arns\_map](#input\_policy\_arns\_map) | Policy ARNs to attach (descriptive key => arn). | `map(string)` | `{}` | no |
| <a name="input_sm_base_path"></a> [sm\_base\_path](#input\_sm\_base\_path) | The base path for AWS Secret Manager parameters where secrets are stored. | `string` | `"/system_user/"` | no |
| <a name="input_sm_enabled"></a> [sm\_enabled](#input\_sm\_enabled) | Set `true` to store secrets in AWS Secret Manager, `<br>false` to store secrets in Terraform state as outputs.<br>Since Terraform state would contain the secrets in plaintext,<br>use of AWS Secret Manager is recommended. | `bool` | `true` | no |
| <a name="input_sm_ses_smtp_password_enabled"></a> [sm\_ses\_smtp\_password\_enabled](#input\_sm\_ses\_smtp\_password\_enabled) | Whether or not to create an SES SMTP password. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags. | `map(string)` | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | The access key ID |
| <a name="output_secret_access_key"></a> [secret\_access\_key](#output\_secret\_access\_key) | When `sm_enabled` is `false`, this is the secret access key for the IAM user.<br>This will be written to the state file in plain-text.<br>When `sm_enabled` is `true`, this output will be empty to keep the value secure. |
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | Secret Manager ARN under which the IAM User's access and private key ID is stored |
| <a name="output_ses_smtp_password_v4"></a> [ses\_smtp\_password\_v4](#output\_ses\_smtp\_password\_v4) | When `sm_enabled` is false, this is the secret access key converted into an SES SMTP password<br>by applying AWS's Sigv4 conversion algorithm. It will be written to the Terraform state file in plaintext.<br>When `sm_enabled` is `true`, this output will be empty to keep the value secure. |
| <a name="output_sm_enabled"></a> [sm\_enabled](#output\_sm\_enabled) | `true` when secrets are stored in Secret Manager, `false` when secrets are stored in Terraform state as outputs. |
| <a name="output_user_arn"></a> [user\_arn](#output\_user\_arn) | The ARN assigned by AWS for this user |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | Normalized IAM user name |
| <a name="output_user_unique_id"></a> [user\_unique\_id](#output\_user\_unique\_id) | The unique ID assigned by AWS |

### Examples

```hcl
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

  name = var.name

  force_destroy         = true
  create_iam_access_key = var.create_iam_access_key
  inline_policies       = [data.aws_iam_policy_document.deny.json]
  sm_enabled            = var.sm_enabled
  sm_base_path          = var.sm_base_path

  sm_ses_smtp_password_enabled = var.sm_ses_smtp_password_enabled
}
```

<!-- END_TF_DOCS -->


<!-- references -->

[repo_link]: https://github.com/Infrastrukturait/terraform-aws-iam-simple
