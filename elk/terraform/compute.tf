resource "aws_instance" "es_instance_1" {
    ami = "${var.aws_test_ami}"
    availability_zone = "us-east-1b"
    instance_type = "${var.aws_test_type}"
    security_groups = ["${aws_security_group.elk-test-sg.id}"]
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    vpc_security_group_ids = ["${aws_security_group.elk-test-sg.id}"]
    key_name = "elk_poc"
    associate_public_ip_address = true
    tags = { 
        service = "ansible-nyc-demo"
        role = "elasticsearch"
        env = "dev"
        es_node_master = "true"
    }
    iam_instance_profile = "${aws_iam_instance_profile.es_iam_profile.name}"
    user_data = "${file("bootstrap.sh")}"
}

resource "aws_instance" "es_instance_2" {
    ami = "${var.aws_test_ami}"
    availability_zone = "us-east-1b"
    instance_type = "${var.aws_test_type}"
    security_groups = ["${aws_security_group.elk-test-sg.id}"]
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    vpc_security_group_ids = ["${aws_security_group.elk-test-sg.id}"]
    key_name = "elk_poc"
    associate_public_ip_address = true
    tags = { 
        service = "ansible-nyc-demo"
        role = "elasticsearch"
        env = "dev"
        es_node_data = "true"
    }
    iam_instance_profile = "${aws_iam_instance_profile.es_iam_profile.name}"
    user_data = "${file("bootstrap.sh")}"
}

resource "aws_instance" "kibana_instance_1" {
    ami = "${var.aws_test_ami}"
    availability_zone = "us-east-1b"
    instance_type = "${var.aws_test_type}"
    security_groups = ["${aws_security_group.elk-test-sg.id}"]
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    vpc_security_group_ids = ["${aws_security_group.elk-test-sg.id}"]
    key_name = "elk_poc"
    associate_public_ip_address = true
    tags = { 
        service = "ansible-nyc-demo"
        role = "kibana"
        env = "dev"
    }
    iam_instance_profile = "${aws_iam_instance_profile.es_iam_profile.name}"
    user_data = "${file("bootstrap.sh")}"
}

resource "aws_instance" "logstash_instance_1" {
    ami = "${var.aws_test_ami}"
    availability_zone = "us-east-1b"
    instance_type = "${var.aws_test_type}"
    security_groups = ["${aws_security_group.elk-test-sg.id}"]
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    vpc_security_group_ids = ["${aws_security_group.elk-test-sg.id}"]
    key_name = "elk_poc"
    associate_public_ip_address = true
    tags = { 
        service = "ansible-nyc-demo"
        role = "logstash"
        env = "dev"
    }
    iam_instance_profile = "${aws_iam_instance_profile.es_iam_profile.name}"
    user_data = "${file("bootstrap.sh")}"
}


output "es_instance_1.public_ip" {
    value = "${aws_instance.es_instance_1.public_ip}"
}
output "es_instance_1.private_ip" {
    value = "${aws_instance.es_instance_1.private_ip}"
}

output "es_instance_2.public_ip" {
    value = "${aws_instance.es_instance_2.public_ip}"
}
output "es_instance_2.private_ip" {
    value = "${aws_instance.es_instance_2.private_ip}"
}

output "kibana_instance_1.public_ip" {
    value = "${aws_instance.kibana_instance_1.public_ip}"
}
output "kibana_instance_1.private_ip" {
    value = "${aws_instance.kibana_instance_1.private_ip}"
}

output "logstash_instance_1.public_ip" {
    value = "${aws_instance.logstash_instance_1.public_ip}"
}
output "logstash_instance_1.private_ip" {
    value = "${aws_instance.logstash_instance_1.private_ip}"
}
