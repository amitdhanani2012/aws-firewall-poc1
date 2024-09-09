variable "aws_access_key" {
  

}

variable "aws_secret_key" {
  
 
}

variable "vpc_cidr_block" {
  description = "VPC network"
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Public Subnet"
  type        = list(string)
  default     = ["10.1.1.0/24","10.1.2.0/24"]
}

variable "firewall_subnet_cidr_block" {
  description = "Firewall Subnet"
  type        = list(string)
  default     = ["10.1.3.0/24","10.1.4.0/24"]
}





variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
}



