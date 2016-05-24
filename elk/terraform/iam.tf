resource "aws_iam_instance_profile" "es_iam_profile" {
    name = "es_iam_profile"
    roles = ["${aws_iam_role.es_iam_profile.name}"]
}

resource "aws_iam_role" "es_iam_profile" {
    name = "es_iam_role"
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

resource "aws_iam_role_policy" "es_iam_profile" {
    name = "es_iam_role_policy"
    role = "${aws_iam_role.es_iam_profile.id}"
    policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeTags"
      ],
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
EOF
}
