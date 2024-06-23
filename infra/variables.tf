variable "app_name" {
  description = "application name"
  type        = string
  default     = "chatbot"
}

variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-northeast-1"
}

variable "db_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 3306
      external = 3306
      protocol = "tcp"
    }
  ]
}

variable "db_name" {
  type        = string
  description = "database name"
  default     = "newproject"
}

variable "db_username" {
  type        = string
  description = "database user name"
  default     = "MysqlaaaaA"
}

variable "db_password" {
  type        = string
  description = "database password"
  default     = "Mysql1aaaaA"
}
