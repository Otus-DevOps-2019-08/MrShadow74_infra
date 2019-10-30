MrShadow74_infra
MrShadow74 Infra repository

# Homework #1
создан аккаунт на GitHub
создан файл anton_emelianov.txt
выполнен первый Pull Request

# Homework #2 ChatOps
создана ветка play-travis
проведена интеграция со Slack
проведена интеграция с Travis

# Homework #3
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

# Homework #4

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

# Homework #5

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

# Homework #6
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

# Homework #7
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

# Homework #8 Ansible-1
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

# Homework #9 Ansible-2
Создана ветка ansible-2
Отключены провижинеры для модулей app и db в terraform
В gitignore добавлено исключение *.retry
Созданы плэйбуки для развертывания по типу
- "один плэйбук, несколько сценариев";
- "множество плэйбуков в одном сценарии"

Для Packer созданы плэйбуки образов packer_app.yml и packer_db.yml, образы пересозданы.

Задание со *
С помощью плагина gcp_compute реализован динамический инвентори.
Для его работы скорректирован ansible.cfg и создан inventory.gcp.yml
Для большего удобства работы сделана группировка хостов по группам.

#Homework #10 Ansible-3
Решил переформатировать файл README.md, вести записи в более детальном формате, ибо сделанное ранее без записей начинает забываться, что приводит к дополнительным затратам времени.
Буду постепенно дополнять все записи по выполненным домашним работам.

В git создана ветка ansible-3

# Ansible: работа с ролями и окружениями

## Роли
Создаем структуру ролей
ansible-galaxy init app
ansible-galaxy init db

Установил ansible-galaxy на основании требований из файла environments/stage/requirements.yml
ansible-galaxy install -r environments/stage/requirements.yml

Заполнил роли на основе ранее созданных плейбуков app.yml и db.yml

## Окружения
Создал директорию environments в директории ansible, в ней созданы prod и stage.
Скорректирован конфигурационный файл ansible.cfg под использование по умолчанию инвентори окружения stage.
Созданы директории group_vars в директориях окружений, настроены конфигурации переменных окружений.
Для группы all ansible в переменных окружений создан файл all с записью env: <имя_переменной>
Для вывода информации о текущем окружении в файлы defaults/main.yml в ролях  добавлена запись env: local

## Организация дерева ansible
Созданы директории playbooks и old, куда перенесы плейбуки и файлы из прошлы ДЗ соответственно. Для перемещений файлов использована команда git mv.
После переносов файлов скорректированы шаблоны packer_app.yml и packer_db.yml
Скорректирован ansible.cfg  с целью оптимизации и улучшения.

## Работа с комьюнити-ролями
Настроил работу обратного проксирования для приложения Reddit с помощью nginx и применением роли jdauphant.nginx
В окружениях создан файл requirements.yml
- src: jdauphant.nginx
version: v2.21.1
На основании прописанных требований установлена комьюнити-роль
ansible-galaxy install -r environments/stage/requirements.yml
В .gitignore добавлена запись jdauphant.nginx для исключения из публикации.

В переменные stage/group_vars/app и prod/group_vars/app добавлены записи
nginx_sites:
default:
- listen 80
- server_name "reddit"
- location / {
proxy_pass http://127.0.0.1:9292;
}

В плейбук приложения в правилах файрвола добавлен в разрешенные порт tcp80
В плейбук app.yml добавлен вызов роли jdauphant.nginx

Проверена работа, приложение доступно как на 80, так и на 9292 портах.

## Ansible Vault
Для безопасной работы с приватными данными используется механизм Ansible Vault.
В файл ansible.cfg добавлена запись

[defaults]
vault_password_file = vault.key

Непосредственно файл сохранён за пределами окружения Git.
Для каждого окружения создан файл credentials.yml, зашифрованный командой ansible-vault encrypt environments/prod/credentials.yml

Для использования функционала Ansible Vault создан плейбук users.yml, добавлен на пыполнение в файл site.yml

Для проверки созданы окружения prod и stage, по команде
su admin
su qauser
выполнены входы в систему с использованием пароля.

Для редактирования переменных нужно использоват команду ansible-vault edit <file>
А для расшифровки: ansible-vault decrypt <file>

## Задание со * Работа с динамическим инвентори
Работа динамического инвентори была настроена в предыдущих ДЗ с использованием модуля gcp_compute.

## Задание с ** Настройка TravisCI

Travis CI
![build status](https://travis-ci.com/Otus-DevOps-2019-08/MrShadow74_infra.svg?branch=master)

Файл .travis.yml дополнен установкой packer, terraform, ansible-lint, tflint

Реализован packer validate для всех шаблонов
Реализован terraform validate и tflint для окружений stage и prod
Реализован ansible-lint для плейбуков Ansible
Добавлен бейдж с статусом билда
