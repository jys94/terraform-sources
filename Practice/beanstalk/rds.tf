resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.main-private-1.id, aws_subnet.main-private-3.id]
}
resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "mariadb-params"
  family      = "mariadb10.4"
  description = "MariaDB parameter group"
  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}
resource "aws_db_instance" "mariadb" {
  # 100 GB of storage, gives us more IOPS than a lower number
  allocated_storage         = 100
  engine                    = "mariadb"
  engine_version            = "10.4.27"
  instance_class            = "db.t2.small"
  identifier                = "mariadb"
  db_name                   = "mydatabase"     # database name
  username                  = "root"           # username
  password                  = var.RDS_PASSWORD # password
  db_subnet_group_name      = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name      = aws_db_parameter_group.mariadb-parameters.name
  # if true: 2 instances synchronized with each other
  multi_az                  = "false"
  vpc_security_group_ids    = [aws_security_group.allow-mariadb.id]
  storage_type              = "gp2"
  backup_retention_period   = 30 # how long you’re going to keep your backups
  # prefered AZ
  availability_zone         = aws_subnet.main-private-1.availability_zone
  # final snapshot when executing terraform destroy
  #final_snapshot_identifier = "mariadb-final-snapshot"
  # skip final snapshot when doing terraform destroy
  skip_final_snapshot       = true
  tags = {
    Name = "mariadb-instance"
  }
}