resource "aws_instance" "db" {
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
