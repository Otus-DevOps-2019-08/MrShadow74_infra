MrShadow74_infra
MrShadow74 Infra repository

Homework #1
создан аккаунт на GitHub
создан файл anton_emelianov.txt
выполнен первый Pull Request

Homework #2 ChatOps
создана ветка play-travis
проведена интеграция со Slack
проведена интеграция с Travis

Homework #3
создана новая ветка cloud-bastion

создан новый аккаунт в GCP
созданы два новых инстанса f1_micro
создано правило для GCP firewall с именем vpn-16721

bastion_IP = 34.89.219.137
someinternalhost_IP = 10.156.0.4

с помощью Pritunl поднят VPN-сервер на хосте bastion
создан пользователь test
сохранена и проверена конфигурция для openvpn клиента с проверкой подключения к хосту someinternalhost
настроен Let's Encrypt 

Дополнительно задание:
описана и настроена организации ssh-подключения до хоста someinternalhost по короткому имени с применением ssh jump host

alias прописан в ~/.ssh/config файле:

Host someinternalhost
HostName 10.156.0.4
User eaa
IdentityFile ~/.ssh/id_rsa
ProxyCommand ssh -A 34.89.219.137 nc %h %p

Homework #4

Установлен Google Cloud SDK
Создан инстанс reddit-app

gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure

Установлены Ruby и Bundler
Установлена MongoDB
Деплой и запуск приложения reddit
git clone -b monolith https://github.com/express42/reddit.git

Создано правило для файрвола
gcloud compute firewall-rules create default-puma-server \
  --allow=tcp:9292 \
  --target-tags=puma-server

Проверка http://35.246.148.158:9292

testapp_IP = 35.198.167.169
testapp_port = 9292

Добавлены файлы скриптов
deploy.sh
install_mongodb.sh
install_ruby.sh
startup_script.sh