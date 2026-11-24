
data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_security_group" "rds" {
  name        = "rds-database-sg"
  description = "Allow inbound database traffic to RDS"
  vpc_id      = data.aws_vpc.default_vpc.id
}

# 2. Allow inbound traffic from an application security group (e.g., MYSQL on 3306)
resource "aws_vpc_security_group_ingress_rule" "allow_inbound_db" {
  security_group_id            = aws_security_group.rds.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  description                  = "Allow MySQL access"
  cidr_ipv4 = "10.0.0.0/16"
}

# 3. Allow outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.rds.id]
}