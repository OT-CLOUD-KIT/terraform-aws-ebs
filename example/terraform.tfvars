instance_id = "i-0a0836ff2478df80d"

subnet_id = "subnet-08a2aa30dbc179a2b"

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
   
  },

]

secondary_existing_ebs_volumes = []

################# Naming Convension #####################

random_alphanumeric_len = 4

bu       = "ot"
app      = "bp"
env      = "d"
resource = "ebs"
tenant   = ""

special = false
upper   = false
number  = true

gen_no_of_names = 1

team    = "infra"
program = "ot"
