# LNC Challenge

[![Build Status](https://api.travis-ci.org/raphapr/lnc-challenge.svg)](https://travis-ci.org/raphapr/ansible-pm2)
[![GitHub Stars](https://img.shields.io/github/stars/raphapr/ansible-pm2.svg)](https://github.com/raphapr/ansible-pm2)

> `lnc-challenge` is an set of [Ansible](http://www.ansible.com) roles that deploys a sample nodejs web server and...
>
> * configures system: common packages, set time zone...
> * installs pm2 to manage node processes
> * installs nginx as reverse proxy (HTTP/HTTPS)
> * installs scripts to load tests and parse log
> * configures cron job to send emails every 12 midnight

## Requirements

* Ubuntu 16.04 LTS
* Ansible >= 2.2
* User with sudo privilegies

## Installation

First of all, download this repository:

```shell
$ git clone https://github.com/raphapr/lnc-challenge.git && cd lnc-challenge
```

Install required roles:

```shell
$ sudo ansible-galaxy install -r requirements.yml
```

## Usage

#### Deploy app

```shell
$ ansible-playbook -i local deploy.yml
```

#### Update deploy to the latest release in this github repository

```shell
$ ansible-playbook -i local update-app.yml
```

#### Rollback app to [n]th last deployment or 1 (default)

```shell
$ ansible-playbook -i local rollback-app.yml -e "n=1"
```

## Scripts

### load_tests

A simple script that does a load test on the web server and returns maximum throughput (requests/sec). It uses wrk with 18 threads and 200 connections.

##### Usage

```shell
$ load_tests
```

##### Output

```shell
Maximum throughput: 1923.41 requests/sec
```

### logparser

A simple script that parse nginx access log (sudo privilegies needed).

##### Usage

```shell
$ logparser
```

##### Output

```shell
 243971 200 /
    1 404   /holycow
    622 499 /
```

## Logging

### node processes

As root:

```shell
$ pm2 logs lnc-server
```

### web server

As root:

```shell
$ cat /var/log/nginx/access.log
```

## Variables

Here is a list of all the default variables for this role, which are also available in `vars/default.yml`:

```yaml
#Configuration
repo_version: master
app_name: lncserver
nodejs_version: 6.x
timezone: America/Maceio

# pm2
pm2_user: root
pm2_service_name: pm2-root
pm2_service_enabled: yes
pm2_service_state: started

# ssmtp
ssmtp_root: lnc.chall3ng3@gmail.com
ssmtp_mailhub: smtp.gmail.com:587
ssmtp_hostname: localhost
ssmtp_rewrite_domain: gmail.com
ssmtp_auth_user: lnc.chall3ng3@gmail.com
ssmtp_auth_pass: dexqiyfdavjeimgc
ssmtp_use_starttls: "YES"
ssmtp_use_tls: "YES"
ssmtp_from_line_override: "YES"

# email receiver
ssmtp_receiver: lnc.chall3ng3@gmail.com
```

Deploy variables are in `vars/{deploy,rollback,update}.yml`
