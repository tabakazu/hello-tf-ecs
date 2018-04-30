# Role for ECS Instance
resource "aws_iam_instance_profile" "ecs-instance" {
  name = "taba-instance-profile"
  role = "${aws_iam_role.ecs-instance.name}"
}

resource "aws_iam_role" "ecs-instance" {
  name               = "taba-ecs-instance-role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerServiceforEC2Role" {
  name       = "AmazonEC2ContainerServiceforEC2Role"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  roles      = ["${aws_iam_role.ecs-instance.name}"]
}


# Role for ECS Service
resource "aws_iam_role" "ecs-service" {
  name               = "taba-ecs-service-role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerServiceRole" {
  name       = "AmazonEC2ContainerServiceRole"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  roles      = ["${aws_iam_role.ecs-service.name}"]
}

