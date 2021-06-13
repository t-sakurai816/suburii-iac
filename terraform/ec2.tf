# 環境変数の読み込み
variable "instance_name" {}
variable "key_name" {}

#AmazonLinux2の最新AMIを取得
data "aws_ami" "recent_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.recent_amazon_linux_2.image_id # latest-AmazonLinux2
  instance_type          = "t3a.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = aws_subnet.public_1a.id
  key_name               = var.key_name
  availability_zone      = "ap-northeast-1a"
  # disable_api_termination = true

  root_block_device {
    volume_type = "standard"
    volume_size = "15"
  }

  tags = {
    Name = var.instance_name
  }

}

# EIP
resource "aws_eip" "instance" {
  instance = aws_instance.instance.id
  vpc      = true
}
