resource "aws_security_group" "firewall-poc-ec2" {
  name   = "firewall-poc-ec2"
  vpc_id = aws_vpc.default.id

  ingress {
    description     = "Allow http request from Load Balancer"
    protocol        = "tcp"
    from_port       = 8080 # range of
    to_port         = 8080 # port numbers
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description     = "Allow http request from Load Balancer"
    protocol        = "tcp"
    from_port       = 8081 # range of
    to_port         = 8081 # port numbers
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    description     = "Allow ssh"
    protocol        = "tcp"
    from_port       = 22 # range of
    to_port         = 22 # port numbers
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
