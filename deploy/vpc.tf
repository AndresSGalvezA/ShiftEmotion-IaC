#VPC
resource "aws_vpc" "pv"{
    cidr_block              = "192.168.0.0/16"
    tags = {
        name                    = "pv"
    }
    enable_dns_hostnames = true
    enable_dns_support   = true
}

#SUBNETS 
resource "aws_subnet" "subnet1"{
    vpc_id                  = aws_vpc.pv.id
    cidr_block              = "192.168.0.0/24"
    tags = {
        name                    = "subnet1"
    }
    availability_zone       = "us-east-1a" 
}
resource "aws_subnet" "subnet2"{
    vpc_id                  = aws_vpc.pv.id
    cidr_block              = "192.168.1.0/24"
    tags = {
        name                    = "subnet2"
    }
    availability_zone       = "us-east-1b" 
}
/*
resource "aws_subnet" "private1"{
    vpc_id                  = aws_vpc.pv.id
    cidr_block              = "192.168.2.0/24"
    tags = {
        name                    = "private1"
    }
    availability_zone       = "us-east-1c" 
}
resource "aws_subnet" "private2"{
    vpc_id                  = aws_vpc.pv.id
    cidr_block              = "192.168.3.0/24"
    tags = {
        name                    = "private2"
    }
    availability_zone       = "us-east-1d" 
}*/

#INTERNET GATEWAY
resource "aws_internet_gateway" "pv_igw"{
    vpc_id                  = aws_vpc.pv.id
    tags = {
        name                    = "Main IGW"
    }
}

#ROUTES TABLES
resource "aws_route_table" "public"{
    vpc_id                  = aws_vpc.pv.id

    route  {
        cidr_block          = "0.0.0.0/0"
        gateway_id          = aws_internet_gateway.pv_igw.id
    }
}
/*
resource "aws_route_table" "private"{
    vpc_id                  = aws_vpc.pv.id
}*/


#ASOCIACIÓN
resource "aws_route_table_association" "subnet1"{
    subnet_id                  = aws_subnet.subnet1.id
    route_table_id             = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet2"{
    subnet_id                  = aws_subnet.subnet2.id
    route_table_id             = aws_route_table.public.id
}
