output "lb_dns" {
  value = aws_lb.my_alb-pub.dns_name
}
