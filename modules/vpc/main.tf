resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    tags = {
        Name = "${var.project_name}--vpc"
    }

}
resource "aws_subnet" "pub1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.project_name}--public-1"
    }

}
resource "aws_subnet" "pub2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone  = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.project_name}--public-2"
    }

}

resource "aws_subnet" "pri1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    tags = {
      Name = "${var.project_name}--pri-1"
    }

}

resource "aws_subnet" "pri2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"
    tags = {
      Name = "${var.project_name}--pri-2"
    }

}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "${var.project_name}--igw"
    }

}

resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.main.id

}
resource "aws_route" "int-gateway" {
    route_table_id = aws_route_table.pub_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "pub1asc" {
    subnet_id = aws_subnet.pub1.id
    route_table_id = aws_route_table.pub_rt.id

}
resource "aws_route_table_association" "pub2asc" {
    subnet_id = aws_subnet.pub2.id
    route_table_id = aws_route_table.pub_rt.id

}
