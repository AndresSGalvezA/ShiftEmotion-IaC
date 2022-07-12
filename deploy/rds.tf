/*CREACIÓN DEL SUBNET GROUP PARA EL MULTI-AZ*/
resource "aws_db_subnet_group" "pvirtualizacion" {
  name         = "pv"
  subnet_ids   = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  
}
/*CREACIÓN DE UN SECURITY GROUP EN ESPECÍFICO*/
resource "aws_security_group" "pvsg" {
  name        = "pvsg"
  vpc_id      = aws_vpc.pv.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}
/*CREACIÓN DEL RDS*/
resource "aws_db_instance" "pvirtualizacion" {
  identifier              = "develop"
  allocated_storage       = 20
  engine                  = "mysql"
  instance_class          = "db.t2.micro"
  port                    = "3306"
  db_subnet_group_name    = aws_db_subnet_group.pvirtualizacion.name
  vpc_security_group_ids  = [aws_security_group.pvsg.id]
  #name                    = "pvirtualizacion"
  username                = var.username
  password                = var.password
  #availability_zone       = "us-east-1a" 
  publicly_accessible      = "true" 
  deletion_protection     = true  
  skip_final_snapshot     = true
  multi_az                = true
}

/*INSERCIÓN DE TABLAS A LA BASE DE DATOS*/
resource "null_resource" "db_setup" {
    depends_on = [aws_security_group.pvsg,aws_db_instance.pvirtualizacion]
    provisioner "local-exec" {
        command = "mysql -u ${aws_db_instance.pvirtualizacion.username} -p${var.password} -h ${aws_db_instance.pvirtualizacion.address} < C:/Users/mache/Desktop/prueba.sql"
    }
} 