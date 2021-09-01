resource "aws_security_group" "sg" {
  name        = "control-msk-traffic"
  description = "Allow MSK inbound and outbound traffic"
  vpc_id      = module.vpc.vpc_id
}