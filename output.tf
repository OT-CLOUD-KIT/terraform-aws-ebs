output "new_ebs_volume_ids" {
  description = "IDs of newly created EBS volumes"
  value       = length(aws_ebs_volume.new) > 0 ? [for vol in aws_ebs_volume.new : vol.id] : []
}

output "attached_existing_ebs_volume_ids" {
  description = "IDs of existing EBS volumes attached"
  value       = var.secondary_existing_ebs_volumes != null ? [for vol in var.secondary_existing_ebs_volumes : vol.volume_id] : []
}

output "user_data_new_volumes" {
  description = "Rendered user data scripts for new EBS volumes"
  value       = length(data.template_file.new_ebs) > 0 ? data.template_file.new_ebs[*].rendered : []
}

output "user_data_existing_volumes" {
  description = "Rendered user data scripts for existing EBS volumes"
  value       = length(data.template_file.existing_ebs) > 0 ? data.template_file.existing_ebs[*].rendered : []
}
