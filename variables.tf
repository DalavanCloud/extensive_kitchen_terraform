variable "instances_ami" {
  description = "The Amazon Machine Image (AMI) to use for the AWS EC2 instances"
  type        = "string"
}

variable "key_pair_name" {
  description = "The name of the key pair to use when building instances"
  type = "string"
}


variable "subnet_availability_zone" {
  description = "The isolated, regional location in which to place the subnet"
  type        = "string"
}
