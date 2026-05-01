output "vpc_id" {
    value = aws_vpc.main.id

}
output "public_subnet_1" {
  value = aws_subnet.pub1.id
}

output "public_subnet_2" {
  value = aws_subnet.pub2.id
}


