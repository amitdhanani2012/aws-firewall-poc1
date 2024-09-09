resource "aws_security_group" "alb-security-group" {

 name        = "alb-security-group"

 description = "Allow HTTP to web server"

 vpc_id      = aws_vpc.default.id


ingress {

   description = "HTTPS ingress"

   from_port   = 8080

   to_port     = 8080

   protocol    = "tcp"

   cidr_blocks = ["0.0.0.0/0"]

 }

ingress {

   description = "HTTPS ingress"

   from_port   = 8081 

   to_port     = 8081

   protocol    = "tcp"

   cidr_blocks = ["0.0.0.0/0"]

 }





egress {

   from_port   = 0

   to_port     = 0

   protocol    = "-1"

   cidr_blocks = ["0.0.0.0/0"]

 }

}
