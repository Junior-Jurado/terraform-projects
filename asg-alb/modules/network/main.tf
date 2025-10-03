resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
	Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
	Name = "${var.project_name}-igw"
  }
}

resource "aws_subnet" "public" {
  for_each = zipmap(var.azs, var.public_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
  tags = {
	Name = "public-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = zipmap(var.azs, var.private_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = each.value
  availability_zone = each.key
  tags = { Name = "private-${each.key}"}
}

# Tabla enrutamiento publica -> IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
	cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.this.id
  }
  tags = {
	Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}

# EIP + NAT por subred publica
resource "aws_eip" "nat_eip" {
  for_each = aws_subnet.public
  depends_on = [ aws_internet_gateway.this ]
}

resource "aws_nat_gateway" "nat" {
  for_each = aws_subnet.public
  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id = each.value.id
  tags = {
	Name = "nat-${each.key}"
  }
}

# Tabla de enrutamiento privada -> NAT
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id = aws_vpc.this.id
  tags = {
	Name = "private-rt-${each.key}"
  }
}

resource "aws_route" "private_nat_route" {
  for_each = aws_route_table.private
  route_table_id = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  # Elegir el NAT de la misma AZ 
  nat_gateway_id = aws_nat_gateway.nat[each.key].id
}

resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}