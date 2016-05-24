# from example found at https://github.com/hectcastro/terraform-aws-vpc

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "elk-vpc" {
    cidr_block = "10.0.0.0/16"
    tags {
        Name = "elk-vpc"
    }
}

resource "aws_internet_gateway" "elk-vpc" {
    vpc_id = "${aws_vpc.elk-vpc.id}"
}

resource "aws_eip" "elk-vpc-nat-ip" {
    vpc = true
}    
resource "aws_nat_gateway" "elk-vpc-gw" {
    allocation_id = "${aws_eip.elk-vpc-nat-ip.id}"
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    depends_on = ["aws_internet_gateway.elk-vpc"]
}
# Private Subnets

resource "aws_subnet" "us-east-1b-private" {
    vpc_id = "${aws_vpc.elk-vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
}

# Public Subnets
resource "aws_subnet" "us-east-1b-public" {
    vpc_id = "${aws_vpc.elk-vpc.id}"
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1b"
}

# Routing for public subnets
resource "aws_route_table" "us-east-1-public" {
    vpc_id = "${aws_vpc.elk-vpc.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.elk-vpc.id}"
    }
}

resource "aws_route_table_association" "us-east-1b-public"{
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    route_table_id = "${aws_route_table.us-east-1-public.id}"
}


