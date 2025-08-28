# VPC
resource "aws_vpc" "this" {
	cidr_block = var.cidr_block
	enable_dns_support = true
	enable_dns_hostnames = true

	tags = {
	  Name = "${var.project_name}"
	}
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
	Name = "${var.project_name}-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
	Name = "${var.project_name}-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
	vpc_id = aws_vpc.this.id
	cidr_block = var.private_subnet_cidr
	availability_zone = var.availability_zone

	tags = {
		Name = "${var.project_name}-private-subnet"
	} 
}

# Public Route Table 
resource "aws_route_table" "public" {
	vpc_id = aws_vpc.this.id

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.this.id
	}

	tags = {
		Name = "${var.project_name}-public-rt"
	}  
}

# Association Public Route Table <-> Public Subnet
resource "aws_route_table_association" "public_assoc" {
	subnet_id = aws_subnet.public.id
	route_table_id = aws_route_table.public.id 
}

# Private Route Table (sin salida a internet aún)
resource "aws_route_table" "private" {
	vpc_id = aws_vpc.this.id
	tags = {
	  Name = "${var.project_name}-private-rt"
	}
}

# Association Private Route Table <-> Private Subnet
resource "aws_route_table_association" "private_assoc" {
	subnet_id = aws_subnet.private.id
	route_table_id = aws_route_table.private.id
  
}