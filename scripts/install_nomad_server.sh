#!/bin/bash


sudo apt-get update
sudo apt-get upgrade -y


sudo apt-get install -y curl unzip docker.io

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker


NOMAD_VERSION="1.6.1"
curl -O https://releases.hashicorp.com/nomad/$${NOMAD_VERSION}/nomad_$${NOMAD_VERSION}_linux_amd64.zip
unzip nomad_$${NOMAD_VERSION}_linux_amd64.zip
sudo mv nomad /usr/local/bin/
sudo chmod +x /usr/local/bin/nomad

sudo useradd --system --home /etc/nomad.d --shell /bin/false nomad
sudo mkdir -p /etc/nomad.d
sudo mkdir -p /opt/nomad/data
sudo chown -R nomad:nomad /opt/nomad


cat <<EOF | sudo tee /etc/nomad.d/nomad.hcl
datacenter = "azure"
data_dir   = "/opt/nomad/data"
bind_addr  = "${current_ip}"

server {
  enabled          = true
  bootstrap_expect = ${server_count}
  %{~ if length(server_ips) > 1 ~}
  server_join {
    retry_join = [${join(",", [for ip in server_ips : format("\"%s\"", ip) if ip != current_ip])}]
  }
  %{~ endif ~}
}

# ACL configuration for security
acl {
  enabled = true
}

ports {
  http = 4646
  rpc  = 4647
  serf = 4648
}

ui_config {
  enabled = true
}

consul {
  address = "127.0.0.1:8500"
}
EOF


CONSUL_VERSION="1.16.0"
curl -O https://releases.hashicorp.com/consul/$${CONSUL_VERSION}/consul_$${CONSUL_VERSION}_linux_amd64.zip
unzip consul_$${CONSUL_VERSION}_linux_amd64.zip
sudo mv consul /usr/local/bin/
sudo chmod +x /usr/local/bin/consul


sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir -p /etc/consul.d
sudo mkdir -p /opt/consul/data
sudo chown -R consul:consul /opt/consul


cat <<EOF | sudo tee /etc/consul.d/consul.hcl
datacenter = "azure"
data_dir   = "/opt/consul/data"
bind_addr  = "${current_ip}"
client_addr = "127.0.0.1"

server = true
bootstrap_expect = ${server_count}

%{~ if length(server_ips) > 1 ~}
retry_join = [${join(",", [for ip in server_ips : format("\"%s\"", ip) if ip != current_ip])}]
%{~ endif ~}

ui_config {
  enabled = true
}

connect {
  enabled = true
}
EOF


cat <<EOF | sudo tee /etc/systemd/system/consul.service
[Unit]
Description=Consul
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
Type=notify
User=consul
Group=consul
ExecStart=/usr/local/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGTERM
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF


cat <<EOF | sudo tee /etc/systemd/system/nomad.service
[Unit]
Description=Nomad
Documentation=https://nomadproject.io/docs/
Wants=network-online.target
After=network-online.target
Requires=consul.service

[Service]
User=nomad
Group=nomad
ExecStart=/usr/local/bin/nomad agent -config=/etc/nomad.d/
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGINT
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable consul
sudo systemctl start consul
sudo systemctl enable nomad
sudo systemctl start nomad


sleep 30


sudo -u nomad nomad acl bootstrap -json | sudo tee /opt/nomad/bootstrap.json
NOMAD_TOKEN="${bootstrap_token}"
echo "export NOMAD_ADDR=http://${current_ip}:4646" | sudo tee -a /etc/environment
echo "export NOMAD_TOKEN=$NOMAD_TOKEN" | sudo tee -a /etc/environment


echo "$NOMAD_TOKEN" | sudo tee /opt/nomad/management.token
sudo chown nomad:nomad /opt/nomad/management.token
sudo chmod 600 /opt/nomad/management.token

echo "Nomad server installation completed!"
echo "Bootstrap token: $NOMAD_TOKEN"