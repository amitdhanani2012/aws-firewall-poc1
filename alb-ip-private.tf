resource "aws_lb_target_group" "my_tg_a-pub" { // Target Group A

 name     = "target-group-a-pub"

 port     = 8080

 protocol = "HTTP"

 vpc_id   = aws_vpc.default.id

}

resource "aws_lb_target_group" "my_tg_b-pub" { // Target Group A

 name     = "target-group-b-pub"

 port     = 8081

 protocol = "HTTP"

 vpc_id   = aws_vpc.default.id

}


resource "aws_lb" "my_alb-pub" {

 name               = "my-alb-pub"

 internal           = false

 load_balancer_type = "application"

 security_groups    = [aws_security_group.alb-security-group.id]

 subnets            = [aws_subnet.public-subnet1.id,aws_subnet.public-subnet2.id]



 tags = {

   Environment = "alb-amit-firewall-test-pub"

 }

}

resource "aws_lb_listener" "my_alb_listener1-pub" {

 load_balancer_arn = aws_lb.my_alb-pub.arn

 port              = "8080"

 protocol          = "HTTP"



 default_action {

   type             = "forward"

   target_group_arn = aws_lb_target_group.my_tg_a-pub.arn

 }

}

resource "aws_lb_listener" "my_alb_listener2-pub" {

 load_balancer_arn = aws_lb.my_alb-pub.arn

 port              = "8081"

 protocol          = "HTTP"



 default_action {

   type             = "forward"

   target_group_arn = aws_lb_target_group.my_tg_b-pub.arn

 }

}
