module "naming" {
  source   = "git@github.com:OT-CLOUD-KIT/terraform-aws-naming.git?ref=dev"
  bu       = var.bu
  env      = var.env
  app      = var.app
  tenant   = var.tenant
  resource = var.resource
}

module "standard_tags" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-standard-tagging.git?ref=dev"

  bu      = var.bu
  program = var.program
  app     = var.app
  team    = var.team
  region  = var.region
  env     = var.env
}


module "ebs_volumes" {
  source                          = "git@github.com:OT-CLOUD-KIT/terraform-aws-ebs.git?ref=Feature"
  instance_id                     = var.instance_id
  bu                        = var.bu
  program                   = var.program
  team                      = var.team
  app                       = var.app
  env                       = var.env
  subnet_id                       = var.subnet_id
  secondary_ebs_volumes           = var.secondary_ebs_volumes
  secondary_existing_ebs_volumes = var.secondary_existing_ebs_volumes
}
