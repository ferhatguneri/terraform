#Crate multiple disk snapshot in aws
variable "ebs_volumes" {
  default = [
    "New-Elastix",
    "Terraform",
    "Windows10Pro",
    "DiskNames"
  ]
}

data "aws_ebs_volume" "ebs_volume" {
  count = "${length(var.ebs_volumes)}"

  filter {
    name   = "tag:Name"
    values = ["${var.ebs_volumes[count.index]}"]
  }
}

output "ebs_volume_ids" {
  value = ["${data.aws_ebs_volume.ebs_volume.*.id}"]
}

resource "aws_ebs_snapshot" "ebs_volume" {
  count     = "${length(var.ebs_volumes)}"
  volume_id = "${data.aws_ebs_volume.ebs_volume.*.id[count.index]}"
  description = "${timestamp()}"
}
