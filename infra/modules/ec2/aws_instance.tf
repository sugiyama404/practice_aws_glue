resource "aws_key_pair" "keypair" {
  key_name   = "${var.app_name}-keypair"
  public_key = file("./modules/ec2/src/todolist-keypair.pub")

  tags = {
    Name = "${var.app_name}-keypair"
  }
}

resource "aws_instance" "opmng_server" {
  ami                         = data.aws_ami.app.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet-public-subnet-1a-id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    var.security-group-opmng-id
  ]
  key_name  = aws_key_pair.keypair.key_name
  user_data = <<EOF
#!/bin/bash
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo yum update -y
sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el8-9.noarch.rpm
sudo yum install -y yum-utils
sudo yum-config-manager --disable mysql80-community
sudo yum-config-manager --enable mysql57-community
sudo yum install -y mysql-community-client
sudo yum install mysql -y

sleep 500

function connect_mysql() {
  local result
  result=$(mysql -h${var.db_address} \
  -D${var.db_name} \
  -u${var.db_username} \
  -p${var.db_password} \
  -e "quit" &>/dev/null)
  if [ $? -ne 0 ]; then
    echo "接続に失敗しました。" >&2
    exit 1
  fi
  return 0
}

for i in $(seq 1 200); do
  if connect_mysql; then
    break
  else
    sleep 30
  fi
done

mysql -h${var.db_address} \
  -D${var.db_name} \
  -u${var.db_username} \
  -p${var.db_password} \
  -e "
  CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) DEFAULT NULL,
    email VARCHAR(100) DEFAULT NULL,
    password VARCHAR(255) DEFAULT NULL,
    age INT DEFAULT NULL,
    gender VARCHAR(10) DEFAULT NULL,
    occupation VARCHAR(100) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
"

mysql -h${var.db_address} \
  -D${var.db_name} \
  -u${var.db_username} \
  -p${var.db_password} \
  -e "
  INSERT INTO users (username, email, password, age, gender, occupation) VALUES
  ('alice', 'alice@example.com', 'hashed_password1', 25, 'F', 'Engineer'),
  ('bob', 'bob@example.com', 'hashed_password2', 30, 'M', 'Designer'),
  ('charlie', 'charlie@example.com', 'hashed_password3', 28, 'M', 'Teacher'),
  ('david', 'david@example.com', 'hashed_password4', 35, 'M', 'Architect'),
  ('eva', 'eva@example.com', 'hashed_password5', 22, 'F', 'Student'),
  ('frank', 'frank@example.com', 'hashed_password6', 40, 'M', 'Manager'),
  ('grace', 'grace@example.com', 'hashed_password7', 27, 'F', 'Nurse');
"
EOF

  tags = {
    Name = "${var.app_name}-opmng-ec2"
    Type = "app"
  }
}
