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
  subnet_id                   = var.subnet_public_subnet_1a_id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    var.sg_opmng_id
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
  result=$(mysql -h${var.sorce_db_address} \
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

mysql -h${var.sorce_db_address} \
  -D${var.db_name} \
  -u${var.db_username} \
  -p${var.db_password} \
  -e "
CREATE TABLE IF NOT EXISTS users (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) DEFAULT NULL,
email VARCHAR(255) DEFAULT NULL,
password VARCHAR(255) DEFAULT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);"

mysql -h${var.sorce_db_address} \
  -D${var.db_name} \
  -u${var.db_username} \
  -p${var.db_password} \
  -e "
INSERT INTO users (username, email, password) VALUES
('alice', 'alice@example.com', 'password123'),
('bob', 'bob@example.com', 'password456'),
('charlie', 'charlie@example.com', 'password789'),
('david', 'david@example.com', 'password012'),
('eve', 'eve@example.com', 'password345');
"
EOF

  tags = {
    Name = "${var.app_name}-opmng-ec2"
    Type = "app"
  }
}
