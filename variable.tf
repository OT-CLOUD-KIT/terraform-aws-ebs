variable "secondary_ebs_volumes" {
  description = "List of new EBS volume definitions"
  type = list(object({
    device_name          = string
    mount_point          = string
    volume_size          = number
    encrypted            = bool
    kms_key_id           = optional(string)
    final_snapshot       = optional(bool, false)
    multi_attach_enabled = optional(bool, false)
    iops                 = optional(number)
    throughput           = optional(number)
    type                 = string
    snapshot_id          = optional(string)
    outpost_arn          = optional(string)
  }))
  default = [
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
}

variable "secondary_existing_ebs_volumes" {
  description = "List of existing EBS volumes to attach"
  type = list(object({
    device_name = string
    volume_id   = string
    mount_point = string
  }))
  default = []
}

variable "subnet_id" {
  description = "Subnet ID for determining AZ"
  type        = string
  default     = "subnet-08a2aa30dbc179a2b"
}

variable "instance_id" {
  description = "Instance ID to attach EBS volumes"
  type        = string
  default     = "i-0a0836ff2478df80d"
}


################################## Naming convention variables #########################################

variable "bu" {
  description = "Business unit name (e.g., BP, GURUKU). Max 6 characters."
  type        = string
  default = "BP"
  validation {
    condition     = length(var.bu) <= 6
    error_message = "The business unit name must be less than or equal to 6 characters."
  }
}

variable "program" {
  description = "Name of the program (e.g., OT, BP)."
  type        = string
  default = "OT"
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 6 characters."
  type        = string
  default = "network"
  validation {
    condition     = length(var.app) <= 10
    error_message = "The app name must be less than or equal to 10 characters."
  }
}

variable "env" {
  description = "Environment code: 'd' (dev), 'p' (prod), 'q' (qa), 's' (stage), 'g' (global)."
  type        = string
  default = "d"

  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "team" {
  description = "Team email responsible for the application (e.g., digitalops@gehealthcare.com)."
  type        = string
  default = "infra"
}

variable "region" {
  description = "AWS region (e.g., us-east-1, ap-south-1)."
  type        = string
  default = "us-east-1"
}
