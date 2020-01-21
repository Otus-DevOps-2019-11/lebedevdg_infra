# lebedevdg_infra
lebedevdg Infra repository

# ДЗ №3
## Подключение через бастион в одну команду
ssh -i ~/.ssh/appuser -A -J appuser@35.217.54.123 appuser@10.166.0.4

## Данные для подключения
bastion_IP = 35.217.54.123
someinternalhost_IP = 10.166.0.4
