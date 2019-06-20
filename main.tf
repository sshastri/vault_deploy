module consul_cluster {
  source             = "<CONSUL_MODULE_SOURCE>"
  cluster_name       = "${var.cluster_name}"
  instance_type      = ""
  ssh_key_name       = ""
  ami_id             = "${data.aws_ami.consul_latest.id}"
  private_subnets    = "${data.aws_subnet_ids.vpc_subnets}"
  availability_zones = []
  vpc_id             = "${local.vpc_id}"
  cluster_size       = "${var.consul_cluster_size}"
  ...
}


module vault_cluster {
  source             = "<VAULT_MODULE_SOURCE"
  instance_type      = "t2.large"
  ssh_key_name       = ""
  cluster_name       = "${var.cluster_name}"
  ami_id             = "${data.aws_ami.vault_latest.id}"
  ...
}
