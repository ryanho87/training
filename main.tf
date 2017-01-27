#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-7e50c21a
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-beetle
#

#AKIAJVZ7S7DSMFI4ESDA
#VJa1W3Hi7nDDwudm3eW/CT0ouOS0NEGnCaFZO0t2

/*module "database" {
  source         = "./Ryan"
  aws_access_key = "AKIAJVZ7S7DSMFI4ESDA"
  aws_secret_key = "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"
  aws_region         = "us-west-1"
}*/

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  default = "us-west-1"
}

variable "webs" {
  default = "5"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7e50c21a"
  vpc_security_group_ids = ["sg-29ef374e"]
  count                  = "${var.webs}"

  tags {
    Identity = "autodesk-beetle"
    Name     = "web ${count.index+1}/${var.webs}"
    Foo      = "spiderman"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "tags" {
  value = ["${aws_instance.web.*.tags}"]
}
