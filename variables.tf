variable "region" {
  type = string
  default = "us-west-2"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "common_tags" {
  default = {
  Owner = "Bohdan Zaiachkovskyi"
  Project = "SoftServe_education"
    }
}

variable "os_image" {
    type = string
    default = "ami-0892d3c7ee96c0bf7"
}