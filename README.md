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

testapp_IP = 35.246.148.158
testapp_port = 9292

Добавлены файлы скриптов
deploy.sh
install_mongodb.sh
install_ruby.sh
startup_script.sh

gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--metadata-from-file starup-script=./startup_script.sh

Homework #5

Создана ветка packer-base
Создана директория config-scripts, в неё перенесены файлы
deploy.sh
install_mongodb.sh
install_ruby.sh
startup_script.sh
Создана директория packer с подкаталогом scripts, в него помещены файлы install_mongodb.sh, install_ruby.sh
Создан файл ubuntu16.json
Создан файл variables.json и variables.json.example
С помощью packer создан образ с предустановленными пакетами для развёртывания приложения
packer build ubuntu16.json
Развёрнуто приложение reddit

Выполнено самостоятельное задание
Созданы файлы variables.json, variables.json.example
Файл variables.json добавлен в исключения /.git/info/exclude

Выполнено задание со *
Создан файл immutable.json для создания VM семейства reddit-full

Homework #6
Создана ветка terraform-1
Создана директория terraform
Установлен terraform -v 0.12.9
В файле main.tf создан первый конфигурационный файл для terraform, в котором на базе ранее созданного образа разворачивается сервер с приложением.
Создан файл outpits.tf для упрощения работы с выходными переменными конфигурации
Создан файл variables.tf  с перечнем переменных к конфигурационному файлу

Выполнено самостоятельное задание: созданы переменные для приватного ключа, для указания зоны в инстансе, отформатированы файлы с помощью команды terraform fmt.

Выполнено задание со *
Добавлены ssh-ключи пользователей appuser, appuser1, appuser2. Через web-интерфейс добавлен ключ пользователя appuser_web.
После выполнения terraform apply ключ пользователя appuser_web будет удалён, так как его нет в конфигурации terraform.

Выполнено задание с **
Создан файл lb.tf с конфигурацией terraform с созданием HTTP балансировщика на инстансах reddit-app1 и reddit-app2.
Узким местом такой конфигурации будет необходимость каждый раз править код для расширения количества узлов балансировки. Решением проблемы является создание количества узлов переменной count.

Homework #7
Создана ветка terraform-2
Созданы prod и stage
Созданы модули app, db, vpc
Создан файл storage-bucket.tf

Выполнено задание со *
Настроено хранение файла состояния в облаке

Выполнено задание с **
Сконфигурировано авторазворачивание приложений
Настроены провиженеры
Изменена переменная DATABASE_URL

Homework #8 Ansible-1
Создана вветка ansible-1
Установлен ansible
Cоздан файл inventory, в последствии переработан для групповой обработки хостов
Создан файл ansible.cfg с параметрами работы ansible
Создан файл inventory.yml
Создан файл ansible/clone.yml с playbook для загрузки приложения reddit

При первом выполнении команды ansible-playbook clone.yml получаем

PLAY RECAP **********************************************************************************************************
appserver               : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

Выполнили команду ansible app -m command -a 'rm -rf ~/reddit', удалив тем самым каталог reddit

При повторном выполнении ansible-playbook clone.yml получаем
PLAY RECAP **********************************************************************************************************
app.example.com               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

changed=1 говорит нам о том, что один хост при выполнении плэйбук был изменен - была выполнена команда git и клонирование репозитория согласно плэйбука.

Задание со *
Создан файл inventory.json в формате динамического инвентори.
Динамический инвентори формируется в процессе выполнения формирующего скрипта, в моём случае Python
Если используется параметр --list, тогда возвращется полный список хостов в виде инвентори.
Если используется параметр --host <hostname>, возвращаются список всех переменных для заданного хоста.
Секция _meta позволяет получить все необходимые переменные.

Для выполнения задания было сделано следующее:
В файле ansible.cfg скорректирована строка inventory под работу скрипта
inventory = ./inventory.py

Сформирован файл inventory.json под динамическое формирование инвентори

Создан скрипт inventory.py для получения необходимых данных. Скрипт возвращает доступные значения для заданных параметров в inventory.json
