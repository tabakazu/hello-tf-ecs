# ECS Instance
resource "aws_instance" "1" {
  ami                         = "ami-a99d8ad5"
  instance_type               = "t2.micro"
  subnet_id                   = "${aws_subnet.public-1a.id}"
  private_ip                  = "10.0.0.100"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = ["${aws_security_group.ec2.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.ecs-instance.name}"
  user_data                   = <<EOF
#!/bin/bash

echo ECS_CLUSTER=taba-cluster >> /etc/ecs/ecs.config
EOF
}

resource "aws_instance" "2" {
  ami                         = "ami-a99d8ad5"
  instance_type               = "t2.micro"
  subnet_id                   = "${aws_subnet.public-1c.id}"
  private_ip                  = "10.0.1.100"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = ["${aws_security_group.ec2.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.ecs-instance.name}"
  user_data                   = <<EOF
#!/bin/bash

echo ECS_CLUSTER=taba-cluster >> /etc/ecs/ecs.config
EOF
}