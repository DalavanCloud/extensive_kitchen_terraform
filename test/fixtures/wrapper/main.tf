provider "aws" {
  profile = "047353107634-Administrator"
  region = "us-east-1"
}

resource "tls_private_key" "test_private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "test_key_pair" {
  key_name_prefix = "test-kitchen"
  public_key      = "${tls_private_key.test_private_key.public_key_openssh}"
}

resource "local_file" "test_private_key" {
    content  = "${tls_private_key.test_private_key.private_key_pem}"
    filename = "${path.module}/../../assets/id_${var.kitchen_platform}_rsa"
}

resource "local_file" "test_public_key" {
    content  = "${tls_private_key.test_private_key.public_key_openssh}"
    filename = "${path.module}/../../assets/id_${var.kitchen_platform}_rsa.pub"
}

module "extensive_kitchen_terraform" {
  instances_ami = "${var.instances_ami}"

  # The generated key pair will be used to configure SSH authentication
  key_pair_name = "${aws_key_pair.test_key_pair.key_name}"

  # The source of the module is the root directory of the Terraform project
  source                   = "../../../"
  subnet_availability_zone = "${var.subnet_availability_zone}"
}
