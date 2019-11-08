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
Скорректирован ansible.cfg с целью оптимизации и улучшения.

## Работа с комьюнити-ролями
Настроил работу обратного проксирования для приложения Reddit с помощью nginx и применением роли jdauphant.nginx

В окружениях создан файл requirements.yml
- src: jdauphant.nginx
- version: v2.21.1

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

В плейбук приложения в правилах файрвола добавлен в разрешенные порт tcp80.
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

Для редактирования переменных нужно использоват команду ansible-vault edit <file>.
А для расшифровки: ansible-vault decrypt <file>

## Задание со * Работа с динамическим инвентори
Работа динамического инвентори была настроена в предыдущих ДЗ с использованием модуля gcp_compute.

## Задание с ** Настройка TravisCI

Travis CI
![build status](https://travis-ci.com/Otus-DevOps-2019-08/MrShadow74_infra.svg?branch=master)

Файл .travis.yml дополнен установкой packer, terraform, ansible-lint, tflint

 - Реализован packer validate для всех шаблонов;
 - Реализован terraform validate и tflint для окружений stage и prod;
 - Реализован ansible-lint для плейбуков Ansible;
 - Добавлен бейдж с статусом билда.

# Homework #11 Ansible-4

Создана ветка ansible-4

## Локальная разработка с Vagrant

### Установка Vagrant

Устанавливаем VirtualBox ```apt install virtualbox```

Устанавливает дистрибутив Vagrant	https://www.vagrantup.com/downloads.html скачиваем и устанавливаем вариант для Linux, так как рабочая среда Ubuntu

Проверяем установку: vagrant -v
```
vagrant --version
Vagrant 2.2.6
```
Создал файл Vagrantfile с конфигурацией двух виртуальных машин dbserver и appserver

Добавил в `.gitignore` исключения для Vagrant и Molecule:

```
#Vagrant & molecule
.vagrant/
*.log
*.pyc
.molecule
.cache
.pytest_cache
```

Командой `vagrant up` создадим виртуальные машины dbserver и appserver.

Проверяем список и статус локальных машин
```
vagrant box list
vagrant status
```
Проверяем доступ к созданным виртуальным машинам по ssh
```
vagrant ssh appserver
vagrant ssh dbserver
```
Подключение проходит успешно, ping между ними проходит успешно.

### Доработка ролей

Провижининг

Добавил провижининг для хоста dbserver, проверил его работу командой `vagrant provision dbserver`

Результат выполнения *failed*, так как требуется Python. Для установки Python создан файл *playbook/base.yml* и добавлен в *site.yml*. Одновременно исключен из выполнения плейбук users.yml

Повторная попытка выполнить провижинер показала, что провижинер заработал, но у нас нет MongoDB. Для исправления данной ситуации добавлены задачи по установке MongoDB из `packer_db.yml`:

 - установка MongoDB вынесена в файл ansible/roles/db/tasks/install_mongo.yml
 - конфигурирование MongoDB вынесено в файл ansible/roles/db/tasks/config_mongo.yml

По аналогии добавлен провижининг для роли *app*

При проверке работы провижинера vagrant provision appserver возникла ошибка добавления файла конфигурации в связи с отсутствием каталога пользователя.

Для исправления ошибки делаем параметризацию роли *ansible/roles/app*
 * В переменные добавлен пользователь по умолчанию deploy_user: appuser
 * Файл puma.service перемещен в шаблоны ansible/roles/app/template/puma.service.j2 с заменой пользователя appuser на переменную deploy_user
 * В таске ansible/roles/app/task/puma.yml пользователь appuser так же заменен на переменную deploy_user

Аналогично скорректирован ansible/playbook/deploy.yml - пользователь appuser заменен на переменную deploy_user

В файл ansible/Vagrant через extra_vars переоперделена переменная deploy_user
```
ansible.extra_vars = {
  "deploy_user" => "ubuntu"}
```
После запуска провижинера `vagrant provision appserver` выполнение успешно.

Проверка *http://10.10.10.20:929* проходит успешно.

Полный тест с нуля проходит успешно.
```
vagrant destroy -f
vagrant up
vagrant destroy -f
```

### Задание со *
После разворачивания виртуальных машин nginx устанавливается, но не работает проброс.

Причина - vagrant использует собственный инвентори, про внешние ничего не знает.

Для корректной работы необходимо добавить в файл *Vagrant* в раздел *extra_vars* следующую конфигурацию
```
          "nginx_sites" => {
            "default" => [
              "listen 80",
              "server_name \"reddit\"",
              "location / {
                proxy_pass http://127.0.0.1:9292;
              }"
            ]
        }
```
После внесения изменений приложение доступно в браузере http://10.10.10.20.

## Тестирование роли. Molecule и Testinfra.

### Установка зависимостей

В файл ansible/requirements.txt добавлены записи новых зависимостей:
```
molecule>=2.6
testinfra>=1.10
python-vagrant>=0.5.15
```
Установка новых зависимостей выполнена с помощью команды `pip install -r requirements.txt`
```
molecule --version
molecule, version 2.22
```
### Тестирование db роли
В директории с ролью ansible/roles/db выполним команду `molecule init scenario --scenario-name default -r db -d vagrant`

В роли *db* создан дефалтовый сценарий для Molecule. В ansible/roles/db/molecule/default/tests/test_default.py создано несколько тестов для проверки
```
# check if MongoDB is enabled and running
def test_mongo_running_and_enabled(host):
    mongo = host.service("mongod")
    assert mongo.is_running
    assert mongo.is_enabled

# check if configuration file contains the required line
def test_config_file(host):
    config_file = host.file('/etc/mongod.conf')
    assert config_file.contains('bindIp: 0.0.0.0')
    assert config_file.is_file
```
Создадим виртуальную машину для проверки роли. В директории `ansible/roles/db` выполните команду:
`
$ molecule create
`
В результате будет создана ВМ.
Посмотрим список созданных инстансов, которыми управляет Molecule с помощью команды
`
$ molecule list
`
Подключимся по SSH внутрь ВМ с помощью команды
`
$ molecule login -h instance
`
Дополним плейбук Molecule `db/molecule/default/playbook.yml`:
`
---
- name: Converge
  become: true
  hosts: all
  vars:
    mongo_bind_ip: 0.0.0.0
  roles:
  - role: db
`
Применим playbook.yml в котором вызывается наша роль к созданному хосту
`
$ molecule converge
`
и выполним для неё тест
`
$ molecule verify
`
## Самостоятельное задание

### Реализовать проверки того, что БД слушает по порту tcp 27017.
* Сделано с использованием модуля Testinfra *testinfra.modules.socket.Socket class*
`
# check if listen port tcp:27017
def test_listen_mongo_port(host):
    assert host.socket("tcp://0.0.0.0:27017").is_listening
`
### Переназначение ролей app и db в плейбуках packer_app.yml и packer_db.yml

После изменения ролей необходимо внести изменения в файлы сборки образов packer.

### Провижининг db.json
* В таски ansible/roles/db/tasks/main.yml добавлены теги для разделения процессов
`
- import_tasks: install_mongodb.yml
  tags:
    - db_install_mongo

- import_tasks: config_mongodb.yml
  tags:
    - db_config_mongo
`
* В плейбуке packer_db.yml вместо провижинера указываем роль
`
roles:
  - db
`
* В файле packer/db.json добавлены разделы
`
"extra_arguments": ["--tags","db_install_mongo"],
"ansible_env_vars": ["ANSIBLE_ROLES_PATH={{ pwd }}/ansible/roles"]
`
### Провижиринг app.json

* В таски ansible/roles/app/tasks/main.yml добавлены теги для разделения процессов
`
- include: ruby.yml
  tags:
   - ruby_app

- include: puma.yml
  tags:
   - puma_app
`
* В плейбуке packer_app.yml вместо провижинера указываем роль
`
roles:
  - app
`
* В файле packer/app.json добавлены разделы
`
"extra_arguments": ["--tags","ruby_app"],
"ansible_env_vars": ["ANSIBLE_ROLES_PATH={{ pwd }}/ansible/roles"]
`
## Задание со *

### Вынос роли DB в отдельный репозиторий
* Создан и склонирован новый репозиторий MrShadow74/ansible-role-db
* В репозиторий перенесен каталог роли DB
* Делаем проверку molecule converge, который завершается ошибкой "не найдена роль DB". Решение находится в документации https://github.com/ansible/molecule/blob/fc90dfd6c8a5fd3a3068b9cc8311dc176ab261cd/molecule/provisioner/ansible.py#L203-L208
* Корректируем ansible-role-db/molecule/default/playbook.yml
`
roles:
    - role: "{{ lookup('env', 'MOLECULE_PROJECT_DIRECTORY') | basename }}"
`
* Добавляю в файлы requirements.yml окружений stage и prod запись
`
- name: ansible-role.db
  src: https://github.com/MrShadow74/ansible-role-db, выгружать ей в репозиторий нет необходимости
`
* Прописываю в исключения .gitignore роль ansible-role-db
* Установка созданной зависимости в окружение stage, в prod ставить не стал
`
ansible-galaxy install -r environments/stage/requirements.yml
`
* Скорректирован плейбук ansible/playbooks/db.yml для роли
`
  roles:
   - ansible-role.db
`
* В ходе тестирования корректности сделанных изменений обнаружил нарушение формирования шаблона db_config.j2 из-за разности имён пользователей в разных средах развёртывания. С помощью оператора ветвления реализована вариативность имени пользователя в зависимости от среды.
`
{% if env == 'local' %}
DATABASE_URL = {{ db_host }}
{% elif env in ['stage', 'prod'] %}
DATABASE_URL = {{ hostvars[groups['db'][0]]['ansible_default_ipv4']['address'] }}
{% endif %}
`
* Так же при сборке образа `packer build db.json` выявлена ошибка роли db в ansible/playbooks/packer_db.yml, внесена корректировка
`
roles:
  - ansible-role.db
`
### Автоматическое тестирование для роли ansible-role.db

На основе примера из домашнего задания https://github.com/Artemmkin/test-ansible-role-with-travis

* Ддобавляю в .gitignore:
*.log
*.tar
*.pub
credentials.json
google_compute_engine

* wget https://raw.githubusercontent.com/vitkhab/gce_test/c98d97ea79bacad23fd26106b52dee0d21144944/.travis.yml
* ssh-keygen -t rsa -f google_compute_engine -C 'TravisCI' -q -N ''
* Добавлю открытый ключ в meta-данные GCP
* Используя имеющийся credentials.json из ранее выполненного ДЗ
* Выполню шифрование переменных:
`
travis encrypt GCE_SERVICE_ACCOUNT_EMAIL='796339086738-compute@developer.gserviceaccount.com' --add --com
travis encrypt GCE_CREDENTIALS_FILE="$(pwd)/credentials.json" --add --com
travis encrypt GCE_PROJECT_ID='infra-253209' --add --com
`
* Выполню шифрование файлов:
`
tar cvf secrets.tar credentials.json google_compute_engine
travis login
travis encrypt-file secrets.tar --add --com
`
