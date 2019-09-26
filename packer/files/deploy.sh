#!/usr/bin/env bash
set -e

git clone -b monolith https://github.com/express42/reddit.git /opt/puma-server
cd /opt/puma-server && bundle install

touch /etc/systemd/system/puma.service
chmod 664 /etc/systemd/system/puma.service
tee /etc/systemd/system/puma.service << EOF
[Unit]
Description=Puma service
[Service]
WorkingDirectory=/opt/puma-server
ExecStart=/usr/local/bin/puma
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start puma
systemctl enable puma

