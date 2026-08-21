#region
variable "regions" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

#vpc
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
#subnet
variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
#instance
variable "instance_name" {
  description = "The name of the instance"
  type        = string
  default     = "test1instance"
}
variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t3.micro"
}
variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-00d2dbb426772b03a"
}
variable "key_pair" {
  description = "The name of the key pair to use for the instance"
  type        = string
  
}
