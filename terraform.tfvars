# terraform.tfvars

region                 = "us-west-2"
db_identifier          = "myapp-database"
db_engine              = "postgres"
db_engine_version      = "14.1"
db_instance_class      = "db.t3.micro"
db_allocated_storage   = 20
db_storage_type        = "gp2"
db_name                = "myappdb"
db_username            = "dbadmin"
db_password            = "YourStrongPasswordHere123!"
db_parameter_group_name = "default.postgres14"
skip_final_snapshot    = true
vpc_security_group_ids = ["sg-0123456789abcdef0"]
multi_az               = false
publicly_accessible    = false

tags = {
  Environment = "Development"
  Project     = "MyApp"
}