# EC2-RDS-WordPress Deployment 🚀

## 📄 Overview
This project automates the deployment of a WordPress site on an AWS EC2 instance with an RDS MySQL database. The stack includes:

- ✅ AWS **EC2 Instance** with Docker
- ✅ AWS **RDS MySQL** database
- ✅ **Dockerized WordPress**
- ✅ **Ansible** for automation
- ✅ **Terraform** for infrastructure as code
- ✅ **Cloudflare** for domain pointing (subdomain support)
- ✅ Automatic WordPress installation via **WP-CLI**

---

## ✨ Features
- AWS account with credentials configured
- Cloudflare account with API Token & Zone ID
- Terraform installed (`>= 1.2.0`)
- Ansible installed
- SSH key pair (for EC2 access)
- `.env` file in the root directory

---

## ⚙️ Prerequisites
- AWS Account with IAM Access
- Terraform (`>= 1.2.0`)
- Ansible installed
- Cloudflare Account with API Token & Zone ID
- SSH key for EC2 access

---

## 🚀 Deployment Steps

### 1. Clone the Repository
```bash
git clone https://github.com/pranav-wadge/EC2-RDS-Wordpress.git
cd EC2-RDS-Wordpress

```

### 2. Initialize and Apply Terraform
```bash
terraform init
terraform apply -auto-approve
```

### 2. Run Deployment Script
```bash
chmod +x deploy.sh
./deploy.sh
```
This script:
- Retrieves instance and database details
- Creates a `.env` file with database credentials
- Copies `.env` to the instance
- Runs the Ansible playbook
- Deploys WordPress with Docker

## 🔐 .env File Example

Create a `.env` file in the root of the project by copying the example:

```bash
cp .env.example .env
# --- Database Configuration (Auto-injected by script) ---
WORDPRESS_DB_HOST=<RDS Host will be auto-injected>
WORDPRESS_DB_USER=admin
WORDPRESS_DB_PASSWORD=adminpassword
WORDPRESS_DB_NAME=wordpress_db

# --- WordPress Configuration ---
WORDPRESS_SITE_TITLE=My Awesome Blog
WORDPRESS_ADMIN_USER=admin
WORDPRESS_ADMIN_PASSWORD=admin123
WORDPRESS_ADMIN_EMAIL=admin@example.com

# --- Cloudflare Configuration ---
CLOUDFLARE_API_TOKEN=your_cloudflare_api_token
CLOUDFLARE_ZONE_ID=your_cloudflare_zone_id
SUBDOMAIN=
ROOT_DOMAIN=
```



### 3. Access WordPress
- Website: [http://pranavwadge.cloud](http://pranavwadge.cloud)
- Admin Panel: [http://pranavwadge.cloud/wp-admin](http://pranavwadge.cloud/wp-admin)
- Admin Credentials:
  - Username: `admin`
  - Password: `Admin@123`


## Cleanup
To delete all resources:
```bash
terraform destroy -auto-approve
```

## Author
- **pranav wadge** - [GitHub](https://https://github.com/pranavwadge/
