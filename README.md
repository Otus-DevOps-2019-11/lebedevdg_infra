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
