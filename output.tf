output "instance_id" {
  value = aws_instance.test1instance.id
}
output "aws_vpc_id" {
  value = aws_vpc.test1vpc.id
}
output "aws_subnet_id" {
  value = aws_subnet.test1subnet.id
}
output "aws_internet_gateway_id" {
  value = aws_internet_gateway.test1igw.id
}
output "aws_route_table_id" {
  value = aws_route_table.test1rt.id
}
output "public_ip" {
  value = aws_instance.test1instance.public_ip
}

output "public_dns" {
  value = aws_instance.test1instance.public_dns
}