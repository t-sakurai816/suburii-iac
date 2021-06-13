########################
### VPC
# https://www.terraform.io/docs/providers/aws/r/vpc.html
########################
resource "aws_vpc" "main" {

  cidr_block = "172.30.0.0/16"

  tags = {
    Name = "main"
  }
}

########################
### Subnet
# https://www.terraform.io/docs/providers/aws/r/subnet.html
########################

# public
resource "aws_subnet" "public_1a" {

  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1a"

  cidr_block = "172.30.1.0/24"

  tags = {
    Name = "main-public-1a"
  }

}

resource "aws_subnet" "public_1c" {

  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1c"

  cidr_block = "172.30.2.0/24"

  tags = {
    Name = "main-public-1c"
  }

}

resource "aws_subnet" "public_1d" {

  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1d"

  cidr_block = "172.30.3.0/24"

  tags = {
    Name = "main-public-1d"
  }

}


#########################
### Internet Gateway
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
#########################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

########################
### Route Table
# https://www.terraform.io/docs/providers/aws/r/route_table.html
########################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-RouteTable-public"
  }
}

########################
### Route
# https://www.terraform.io/docs/providers/aws/r/route.html
########################
resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
}

########################
### Association
# https://www.terraform.io/docs/providers/aws/r/route_table_association.html
########################
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1d" {
  subnet_id      = aws_subnet.public_1d.id
  route_table_id = aws_route_table.public.id
}