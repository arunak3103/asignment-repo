resource "aws_instance" "test" {
    ami = var.ami
    instance_type = "t2.micro"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.sg_id]
    key_name = var.key_name
    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from EC2 - ALB working" > /var/www/html/index.html
              EOF
    tags ={
        Name = "test-inst"
    }

}

