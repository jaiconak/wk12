output "public-ip-address" {
  value = aws_instance.ec2InstanceTestingTerraform.public_ip
}

output "private-address" {
  value = aws_instance.ec2InstanceTestingTerraform.private_ip
}

output "ssh-command" {
  value = "ssh -i ${local_file.name.filename} ec2-user@${aws_instance.ec2InstanceTestingTerraform.public_ip}"
}

output "volume_id" {
  value = aws_ebs_volume.v1.id
}