# Terraform AWS EBS Module

A Terraform module to manage **new and existing EBS volumes** for an EC2 instance. It automates the creation, attachment, and optional mounting of volumes using cloud-init-compatible user data.

---

## Architecture

![image](https://github.com/user-attachments/assets/80d75a92-d0fe-4854-ad1b-4e748728eddb)


> This module helps:
> - Create and attach new EBS volumes to an EC2 instance
> - Attach and mount existing EBS volumes
> - Generate user data scripts to persist EBS mounts on reboot

---



## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|
---

## Usage

```hcl
module "ebs_volumes" {
  source = "OT-CLOUD-KIT/terraform-aws-ebs"

  instance_id = "i-0a0836ff2478df80d"
  subnet_id   = "subnet-08a2aa30dbc179a2b"

  bu      = "ot"
  program = "ot"
  team    = "infra"
  app     = "bp"
  env     = "d"

  secondary_ebs_volumes = [
    {
      device_name          = "/dev/xvdf"
      mount_point          = "/mnt/data1"
      volume_size          = 20
      encrypted            = true
      kms_key_id           = null
      final_snapshot       = false
      multi_attach_enabled = false
      iops                 = null
      throughput           = null
      type                 = "gp3"
      snapshot_id          = null
      outpost_arn          = null
    }
  ]

  secondary_existing_ebs_volumes = []
}


```

## Resource

| Name                                                                                                                              | Type        |
| --------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws\_ebs\_volume.new](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume)                    | resource    |
| [aws\_volume\_attachment.new](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment)      | resource    |
| [aws\_volume\_attachment.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource    |
| [aws\_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet)                     | data source |
| [template\_file.new\_ebs](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)               | data source |
| [template\_file.existing\_ebs](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)          | data source |


---
## Input
| Name                                                                                                                               | Description                                                | Type           | Default                      | Required |
| ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | -------------- | ---------------------------- | :------: |
| <a name="input_instance_id"></a> [**instance\_id**](#input_instance_id)                                                            | EC2 instance ID to which EBS volumes will be attached      | `string`       | `"i-0a0836ff2478df80d"`      |     yes   |
| <a name="input_subnet_id"></a> [**subnet\_id**](#input_subnet_id)                                                                  | Subnet ID used to determine the AZ for EBS volume creation | `string`       | `"subnet-08a2aa30dbc179a2b"` |     yes  |
| <a name="input_secondary_ebs_volumes"></a> [**secondary\_ebs\_volumes**](#input_secondary_ebs_volumes)                             | List of new EBS volume configurations to create            | `list(object)` | See example                  |     No   |
| <a name="input_secondary_existing_ebs_volumes"></a> [**secondary\_existing\_ebs\_volumes**](#input_secondary_existing_ebs_volumes) | List of existing EBS volumes to attach                     | `list(object)` | `[]`                         |     No   |
| <a name="input_random_alphanumeric_len"></a> [**random\_alphanumeric\_len**](#input_random_alphanumeric_len)                       | Length of random string suffix for names                   | `number`       | `4`                          |     No   |
| <a name="input_bu"></a> [**bu**](#input_bu)                                                                                        | Business unit identifier (max 6 characters)                | `string`       | `"ot"`                       |     yes    |
| <a name="input_app"></a> [**app**](#input_app)                                                                                     | Application name (max 10 characters)                       | `string`       | `"bp"`                       |     Yes   |
| <a name="input_env"></a> [**env**](#input_env)                                                                                     | Environment (`d`, `p`, `q`, `s`, `g`)                      | `string`       | `"d"`                        |     Yes   |
| <a name="input_resource"></a> [**resource**](#input_resource)                                                                      | AWS resource name prefix                                   | `string`       | `"ebs"`                      |     No  |
| <a name="input_tenant"></a> [**tenant**](#input_tenant)                                                                            | Tenant identifier (optional)                               | `string`       | `""`                         |     No  |
| <a name="input_special"></a> [**special**](#input_special)                                                                         | Include special characters in generated names              | `bool`         | `false`                      |     No    |
| <a name="input_upper"></a> [**upper**](#input_upper)                                                                               | Use uppercase letters in generated names                   | `bool`         | `false`                      |     No    |
| <a name="input_number"></a> [**number**](#input_number)                                                                            | Include numbers in generated names                         | `bool`         | `true`                       |     Yes   |
| <a name="input_gen_no_of_names"></a> [**gen\_no\_of\_names**](#input_gen_no_of_names)                                              | Number of names to generate                                | `number`       | `1`                          |     No    |
| <a name="input_team"></a> [**team**](#input_team)                                                                                  | Team name or responsible contact                           | `string`       | `"infra"`                    |     /yes    |
| <a name="input_program"></a> [**program**](#input_program)                                                                         | Program or project name                                    | `string`       | `"ot"`                       |     Yes    |



##  Outputs

| Name | Description |
|------|-------------|
| <a name="output_new_ebs_volume_ids"></a> [new\_ebs\_volume\_ids](#output_new_ebs_volume_ids) | IDs of newly created EBS volumes |
| <a name="output_attached_existing_ebs_volume_ids"></a> [attached\_existing\_ebs\_volume\_ids](#output_attached_existing_ebs_volume_ids) | IDs of existing EBS volumes attached to the instance |
| <a name="output_user_data_new_volumes"></a> [user\_data\_new\_volumes](#output_user_data_new_volumes) | Rendered user-data for newly created and mounted volumes |
| <a name="output_user_data_existing_volumes"></a> [user\_data\_existing\_volumes](#output_user_data_existing_volumes) | Rendered user-data for already existing and attached volumes |


## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)
