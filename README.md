# dovecot

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What dovecot affects](#what-dovecot-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dovecot](#beginning-with-dovecot)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

basic dovecot installation

## Module Description

This module is intended to be used by eyp-postfix to setup a virtual domains for postfix using SASL authentication. Anyway, it can also be used to configure dovecot as a standalone service but eyp-postfix is a dependency

## Setup

### What dovecot affects

* package management
* service management
* configuration management:
  * general config file: /etc/dovecot/dovecot.conf
  * local usernames (default: /etc/dovecot/passwd)

### Setup Requirements

This module requires pluginsync enabled.

**dovecot::mail_location** is a prerequisite to be able to deploy **dovecot**

### Beginning with dovecot

basic setup (dovecot with SASL authentication using a file to store passwords):

```
class { 'dovecot': }
class { 'dovecot::userdb': }
class { 'dovecot::passdb': }
class { 'dovecot::auth': }
class { 'dovecot::auth::unixlistener': }
class { 'dovecot::imaplogin': }

dovecot::account { 'demo@demo.systemadmin.es':
  password => 'demopassw0rd',
}
```

## Usage

Right now does not support may options, it's intented to be in a small MTA server (does not support LDAP auth)

## Reference

### classes

#### dovecot

#### dovecot::auth

#### dovecot::auth::unixlistener

#### dovecot::imaplogin

#### dovecot::passdb

#### dovecot::userdb

### defines

#### dovecot::account

## Limitations

Tested on:
* CentOS 6
* CentOS 7
* Ubuntu 14.04
* Ubuntu 16.04

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

* lots of dovecot functionalities still needs to be implemented in this module

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
