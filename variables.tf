variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "dbstorage" {
  description = "Allocated storage for the RDS instance"
  type        = number
  default     = 20  
}
<<<<<<< HEAD
variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
=======
>>>>>>> 2b7c8b0 (update this files)
