[![Build Status](https://travis-ci.com/Otus-DevOps-2019-11/lebedevdg_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2019-11/lebedevdg_infra)

# lebedevdg_infra
lebedevdg Infra repository

# ДЗ №3
## Подключение через бастион в одну команду
ssh -i ~/.ssh/appuser -A -J appuser@35.217.54.123 appuser@10.166.0.4

## Данные для подключения
bastion_IP = 35.217.54.123
someinternalhost_IP = 10.166.0.4

# ДЗ №4

## Данные для подключения
testapp_IP = 35.228.203.183
testapp_port = 9292

## Создание инстанса + инсталяционный скрипт

### С диска
gcloud compute instances create reddit-app3 \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--metadata-from-file startup-script=/root/lebedevdg_infra/install.sh

### C URI

gcloud compute instances create reddit-app4 \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--metadata startup-script-url=gs://test100909/install.sh

### Создание правила firewall

gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server

# Дз №5

## Созданы шаблоны сборки images для packer - ubuntu16.json, immutable.json

## Создан файл переменных variables.json и его example вариант

## Создан инсталяционный скрипт устанавливающий приложение и его зависимости + демонизация приложения и его автозапус - packer/files/install.sh

## Созданы вспомогательные скрипты для сборки образов (полного и нет) - config-scripts/packer_build_full.sh, config-scripts/packer_build.sh
## и скрипт создания инстанса config-scripts/create-redditvm.sh


# Дз №6

## если metadata ssh-keys определена на уровне инстанса VM в terraform, то, если добавить ssh-ключ некого нового пользователя через веб-интерфейс GCE в проект, к уже созданным на этот момент через terraform машинам под этим новым пользователем можно будет сразу подключиться;
## после пересоздания через terraform таких машин подключение к ним также работает как под пользователями, присутствующими в metadata инстанса VM, так и под пользователями, добавленными через веб-интерфейс GCE в проект

## если же метаданные ssh-keys определить на уровне google_compute_project_metadata_item в terraform, то ssh-ключ некого нового пользователя, добавленый через веб-интерфейс GCE в проект, работать не будет;
## такой ключ будет потерян(удален) при terraform apply

# Дз №7

## terraform проект разбит на модули и дополнительно параметризован

## terraform проект разбит на модули и дополнительно параметризован

## terraform проект разбит на модули и дополнительно параметризован


Посмотреть содержимое бакета можно командой:

gsutil ls -r gs://tf-state-strg-bckt/**

## (*) настроено хранение стейт файла в GCS удаленном бэкенде

При хранении стейт файла в удаленном бэкенде корректно работает режим блокировок.
При попытке запустить одновременно terraform apply одной и той же конфигурации из разных мест один из запусков будет неудачным с ошибкой Error locking state,
потому как tflock-файл уже будет существовать, и будет выведена информация о существующей блокировке

## (**) в модули app и db добавлены provisioner для настройки и старта приложения;
## добавлена возможность отключения provisioner (переменная enable_provision)

# Дз №8

## После выполнения ansible app -m command -a 'rm -rf ~/reddit' всегда получаем статус chenget непонятно состояние, нет информации о том, что было сделано.

## Динамический JSON inventory реализован спомощью ansible plugin gcp

# Дз №9

## реализация: один ansible playbook, один сценарий

ansible-playbook reddit_app_one_play.yml --check --limit db --tags db-tag
ansible-playbook reddit_app_one_play.yml --limit db --tags db-tag

ansible-playbook reddit_app_one_play.yml --check --limit app --tags app-tag
ansible-playbook reddit_app_one_play.yml --limit app --tags app-tag

ansible-playbook reddit_app_one_play.yml --check --limit app --tags deploy-tag
ansible-playbook reddit_app_one_play.yml --limit app --tags deploy-tag

# реализация: один playbook, несколько сценариев

ansible-playbook reddit_app_multiple_plays.yml --tags db-tag --check
ansible-playbook reddit_app_multiple_plays.yml --tags db-tag

ansible-playbook reddit_app_multiple_plays.yml --tags app-tag --check
ansible-playbook reddit_app_multiple_plays.yml --tags app-tag

ansible-playbook reddit_app_multiple_plays.yml --tags deploy-tag --check
ansible-playbook reddit_app_multiple_plays.yml --tags deploy-tag

ansible-playbook reddit_app_multiple_plays.yml --check
ansible-playbook reddit_app_multiple_plays.yml

# реализация: несколько плейбуков

ansible-playbook site.yml --check
ansible-playbook site.yml

# сделан dynamic inventory через плагин gcp_compute

ansible-inventory -i inventory.gcp.yml --list
ansible all -i inventory.gcp.yml -m ping

# переделан provision в packer с использованием ansible

packer validate -var-file=packer/variables.json packer/db.json
packer build -var-file=packer/variables.json packer/db.json

packer validate -var-file=packer/variables.json packer/app.json
packer build -var-file=packer/variables.json packer/app.json

# Дз №10

## перенесены созданные плейбуки app и db в соответствующие роли

## созданы два ansible окружения stage и prod со своими настройками, включая dynamic inventory (*)

ansible-playbook playbooks/site.yml --check
ansible-playbook playbooks/site.yml

ansible-playbook -i environments/prod/inventory.gcp.yml playbooks/site.yml --check
ansible-playbook -i environments/prod/inventory.gcp.yml playbooks/site.yml

## изучено использование коммьюнити ролей на примере роли nginx

## изучено применение ansible-vault на примере задачи создания новых пользователей

ansible-vault encrypt environments/stage/credentials.yml
ansible-vault encrypt environments/prod/credentials.yml

ansible-vault edit environments/stage/credentials.yml
ansible-vault edit environments/prod/credentials.yml

ansible-vault decrypt environments/stage/credentials.yml
ansible-vault decrypt environments/prod/credentials.yml

## (**) написаны Travis CI тесты для PR и коммитов в master
##        выполняется packer validate для всех шаблонов
##        выполняется terraform validate и tflint для бакета и stage и prod окружений
##        выполняется ansible-playbook --syntax-check и ansible-lint для всех плейбуков

##        в README.md добавлен бейдж со статусом билда

# Дз №11

- доработаны роли для возможности провижининга в Vagrant, в том числе и настройка nginx (*)

```
# в директории ansible:
vagrant up
# для проверки работы приложения:
curl http://10.10.10.20:9292
# или через nginx:
curl http://10.10.10.20
# затем:
vagrant destroy -f
```

- выполнено локальное (vagrant, virtualbox) тестирование роли db при помощи Molecule и Testinfra

```
# в директории ansible/roles/db:
molecule create
molecule converge
molecule verify
# затем:
molecule destroy
# или все разом:
molecule test
```

- переключена сборка образов с помощью Packer на использование ролей app и db

```
# в директории ansible для проверки вне Packer на предварительно поднятой с помощью Terraform инфраструктуре:
ansible-playbook playbooks/packer_db.yml --limit db --tags install
ansible-playbook playbooks/packer_app.yml --limit app --tags ruby
# в корневой директории репозитория (пере)сборка образов с помощью Packer:
packer build -var-file=packer/variables.json packer/db.json
packer build -var-file=packer/variables.json packer/app.json
```

- (*) роль db вынесена в отдельный репозиторий (https://github.com/lebedevdg/ansible_role_db)

  - к этому репозиторию подключен Travis CI для автотестов роли при помощи Molecule и Testinfra в GCE
  - настроено оповещение в Slack канал о коммитах в этот репозиторий
  - настроено оповещение в Slack канал о результатах билда
  - в README.md у роли добавлен бейдж со статусом билда
  - эта внешняя роль подключена через requirements.yml окружений stage и prod;<br/>плейбук db.yml теперь использует эту внешнюю роль
