
# Render template for new EBS volumes
data "template_file" "new_ebs" {
  count    = length(var.secondary_ebs_volumes)
  template = file("${path.module}/user-data.sh.tpl")
  vars = {
    device_name = var.secondary_ebs_volumes[count.index].device_name
    mount_point = var.secondary_ebs_volumes[count.index].mount_point
  }
}

# Render template for existing EBS volumes
data "template_file" "existing_ebs" {
  count    = length(var.secondary_existing_ebs_volumes)
  template = file("${path.module}/user-data.sh.tpl")
  vars = {
    device_name = var.secondary_existing_ebs_volumes[count.index].device_name
    mount_point = var.secondary_existing_ebs_volumes[count.index].mount_point
  }
}

# Get AZ from subnet
data "aws_subnet" "selected" {
  count = length(var.secondary_ebs_volumes) > 0 ? 1 : 0
  id    = var.subnet_id
}

# Create new EBS volumes with naming and common tags
resource "aws_ebs_volume" "new" {
  count                = length(var.secondary_ebs_volumes)
  availability_zone    = data.aws_subnet.selected[0].availability_zone
  size                 = var.secondary_ebs_volumes[count.index].volume_size
  encrypted            = var.secondary_ebs_volumes[count.index].encrypted
  kms_key_id           = var.secondary_ebs_volumes[count.index].kms_key_id
  final_snapshot       = var.secondary_ebs_volumes[count.index].final_snapshot
  multi_attach_enabled = var.secondary_ebs_volumes[count.index].multi_attach_enabled
  iops                 = var.secondary_ebs_volumes[count.index].iops
  throughput           = var.secondary_ebs_volumes[count.index].throughput
  type                 = var.secondary_ebs_volumes[count.index].type
  snapshot_id          = var.secondary_ebs_volumes[count.index].snapshot_id
  outpost_arn          = var.secondary_ebs_volumes[count.index].outpost_arn

  tags = merge(
    local.common_tags,
    {
      Name = "${local.base_name}-ebs-${count.index + 1}"
    },
    var.secondary_ebs_volumes[count.index].tags
  )
}

# Attach new volumes
resource "aws_volume_attachment" "new" {
  count       = length(var.secondary_ebs_volumes)
  device_name = var.secondary_ebs_volumes[count.index].device_name
  volume_id   = aws_ebs_volume.new[count.index].id
  instance_id = var.instance_id
}

# Attach existing volumes
resource "aws_volume_attachment" "existing" {
  count       = length(var.secondary_existing_ebs_volumes)
  device_name = var.secondary_existing_ebs_volumes[count.index].device_name
  volume_id   = var.secondary_existing_ebs_volumes[count.index].volume_id
  instance_id = var.instance_id
}
