provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "default" {
    default = true
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.mongodb.id}"
  instance_id = "${aws_instance.mongodb.id}"
}

resource "aws_instance" "mongodb" {
    # ami = "ami-0f9cf087c1f27d9b1" ami is used in us-east-1 (N.Virginia)
    ami = "ami-0653e888ec96eab9b"
    instance_type = "t2.medium"
    security_groups = [ "openToAll" ]
    tags = {
        Name = "mongodb"
        Owner = "suryaval"
        Env = "dev"
    }
    key_name = "maglevops"
}

resource "aws_ebs_volume" "mongodb" {
    availability_zone = "us-east-2a"
    size = 16

    tags = {
        Name = "storage-for-mongodb"
    }
}
