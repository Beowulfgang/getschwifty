resource "aws_route53_record" "service" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "${var.subdomain}.${var.zone_name}"
  type    = "A"

  alias {
    name                   = var.load_balancer_dns
    zone_id                = aws_lb.my_lb.zone_id
    evaluate_target_health = true
  }
}

