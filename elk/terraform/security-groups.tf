resource "aws_security_group" "elk-test-sg" {
    name = "elk-test-sg"
    vpc_id = "${aws_vpc.elk-vpc.id}"
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${split(",", var.vpn_ips)}"]
    }
    ingress {
        from_port = 9200
        to_port = 9400
        protocol = "tcp"
        self = true
        cidr_blocks = ["${split(",", var.vpn_ips)}"]
    }
    ingress {
        from_port = 5600
        to_port = 5700
        protocol = "tcp"
        self = true
        cidr_blocks = ["${split(",", var.vpn_ips)}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

