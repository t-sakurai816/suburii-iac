#インスタンスのEIPを出力
output "instance_ip" {
  value = aws_eip.instance.public_ip
}
