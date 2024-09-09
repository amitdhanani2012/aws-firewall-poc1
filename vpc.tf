resource "aws_vpc" "default" {
  cidr_block         = var.vpc_cidr_block
  enable_dns_support = true
  tags = {
    Name = "vpc-tf"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "igw-tf"
  }
}


#resource "aws_eip" "eip_gateway" {
#  domain = "vpc"
#  depends_on = [aws_internet_gateway.default]
#}


resource "aws_subnet" "public-subnet1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet_cidr_block[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
 
}

resource "aws_subnet" "public-subnet2" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.public_subnet_cidr_block[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
}



resource "aws_subnet" "firewall-subnet1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.firewall_subnet_cidr_block[0]
  availability_zone = var.availability_zones[0]


}

resource "aws_subnet" "firewall-subnet2" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.firewall_subnet_cidr_block[1]
  availability_zone = var.availability_zones[1]


}



resource "aws_route_table" "IGWRT" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "10.1.1.0/24"
    vpc_endpoint_id  = tolist(aws_networkfirewall_firewall.aws-firewall1.firewall_status[0].sync_states)[0].attachment[0].endpoint_id

  }

  route {
    cidr_block = "10.1.2.0/24"
    vpc_endpoint_id  = tolist(aws_networkfirewall_firewall.aws-firewall2.firewall_status[0].sync_states)[0].attachment[0].endpoint_id
  }

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }


  tags = {
    Name = "IGWRT"
  }
}

resource "aws_route_table_association" "igwrt-igw" {
  gateway_id     = aws_internet_gateway.default.id
  route_table_id = aws_route_table.IGWRT.id
}

resource "aws_route_table" "rt-public-subnet1" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
   }
  route {
    cidr_block = "0.0.0.0/0"
    vpc_endpoint_id  = tolist(aws_networkfirewall_firewall.aws-firewall1.firewall_status[0].sync_states)[0].attachment[0].endpoint_id
  } 


  

  tags = {
    Name = "rt-public-subnet-1"
  }
}

resource "aws_route_table" "rt-public-subnet2" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    vpc_endpoint_id  = tolist(aws_networkfirewall_firewall.aws-firewall2.firewall_status[0].sync_states)[0].attachment[0].endpoint_id
  }



  tags = {
    Name = "rt-public-subnet-2"
  }
}



resource "aws_route_table_association" "ass-rt-public-subnet1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.rt-public-subnet1.id
}

resource "aws_route_table_association" "ass-rt-public-subnet2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.rt-public-subnet2.id
}



resource "aws_route_table" "rt-firewall-subnet1" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }



  tags = {
    Name = "rt-firewall-subnet1"
  }
}

resource "aws_route_table" "rt-firewall-subnet2" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }



  tags = {
    Name = "rt-firewall-subnet2"
  }
}




resource "aws_route_table_association" "ass-rt-firewall-subnet1" {
  subnet_id      = aws_subnet.firewall-subnet1.id
  route_table_id = aws_route_table.rt-firewall-subnet1.id
}


resource "aws_route_table_association" "ass-rt-firewall-subnet2" {
  subnet_id      = aws_subnet.firewall-subnet2.id
  route_table_id = aws_route_table.rt-firewall-subnet2.id
}



