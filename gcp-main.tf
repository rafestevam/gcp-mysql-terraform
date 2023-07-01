# create My SQL database instance
resource "google_sql_database_instance" "my_sql" {
  name                 = "test-instance-mysql"
  project              = "${var.project_name}"
  region               = "${var.region}"
  database_version     = "MYSQL_8_0"
  
  settings {
    tier = "${var.db_tier}"
#    activation_policy           = "${var.db_activation_policy}"
#    disk_autoresize             = "${var.db_disk_autoresize}"
#    disk_size                   = "${var.db_disk_size}"
#    disk_type                   = "${var.db_disk_type}"
#    pricing_plan                = "${var.db_pricing_plan}"
    
    location_preference {
      zone = "${var.zone}"
    }

#    maintenance_window {
#      day  = "7"  # sunday
#      hour = "3" # 3am  
#    }

    database_flags {
      name  = "log_bin_trust_function_creators"
      value = "on"
    }

#    backup_configuration {
#      binary_log_enabled = true
#      enabled            = true
#      start_time         = "00:00"
#    }

    ip_configuration {
      ipv4_enabled = "true"
      authorized_networks {
        value = "0.0.0.0/0"
      }
    }
  }
}

# create database
resource "google_sql_database" "my_sql_db" {
  name      = "test-db"
  project   = "${var.project_name}"
  instance  = "${google_sql_database_instance.my_sql.name}"
  charset   = ""
  collation = ""
}

# create user
resource "google_sql_user" "my-sql" {
  name     = "dbadmin"
  project  = "${var.project_name}"
  instance = "${google_sql_database_instance.my_sql.name}"
  host     = "%"
  password = "Test@2023"
}