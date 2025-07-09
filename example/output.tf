
output "new_ebs_volume_ids" {
  value = module.ebs_volumes.new_ebs_volume_ids
}

output "attached_existing_ebs_volume_ids" {
  value = module.ebs_volumes.attached_existing_ebs_volume_ids
}

output "user_data_new_volumes" {
  value = module.ebs_volumes.user_data_new_volumes
}

output "user_data_existing_volumes" {
  value = module.ebs_volumes.user_data_existing_volumes
}
