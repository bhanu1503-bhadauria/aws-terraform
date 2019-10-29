output "tg_arn" {
  value = aws_lb_target_group.bhanuTG.arn
  }

output "lb-arn" {
  value = aws_lb.bhanuALB.arn
}
