#Example data resources

data "aws_ami" "consul_latest" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["consul-image-*"]
  }
}

data "aws_subnet_ids" "vpc_subnets" {
  vpc_id = "${local.vpc_id}"
}
