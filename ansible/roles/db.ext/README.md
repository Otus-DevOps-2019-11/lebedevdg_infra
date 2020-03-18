[![Build Status](https://travis-ci.com/lebedevdg/ansible_role_db.svg?branch=master)](https://travis-ci.com/lebedevdg/ansible_role_db)


# ansible_role_db

Example of external Ansible role with Molecule and Testinfra testing in GCE


ansible_role_db
==

Use this role to config MongoDB instance

Role Variables
--------------

defaults/main.yml:

```
# MongoDB port and IP to listen to
mongo_port: 27017
mongo_bind_ip: 127.0.0.1
# Environment (e.g., stage, prod)
env: local
```

Example Playbook
----------------

```
- name: Configure MongoDB
  hosts: db
  become: true
  vars:
    mongo_port: 27017
    mongo_bind_ip: 127.0.0.1
    env: local
  roles:
    - ansible_role_db
```
