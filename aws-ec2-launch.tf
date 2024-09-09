
#ami-0bfddf4206f1fa7b9 - amazon linux based new ami created which is ami-01245cd0faa195521 
resource "aws_launch_template" "ec2_launch_templ" {
  name_prefix   = "ec2_launch_templ"
  image_id      = "ami-01245cd0faa195521" # To note: AMI is specific for each region
  instance_type = "t2.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.firewall-poc-ec2.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "poc-ec2-instance" # Name for the EC2 instances
    }
  }
}



resource "aws_autoscaling_group" "firewall-ec2-asg" {
  # no of instances
  desired_capacity = 2
  max_size         = 3
  min_size         = 2

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.my_tg_a-pub.arn,aws_lb_target_group.my_tg_b-pub.arn]

  vpc_zone_identifier = [aws_subnet.public-subnet1.id,aws_subnet.public-subnet1.id] 

  launch_template {
    id      = aws_launch_template.ec2_launch_templ.id
    version = "$Latest"
  }
}

