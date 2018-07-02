# CHANGELOG

## 0.1.12

* Added Ubuntu 18.04 support

## 0.1.11

* added **password_scheme** to **dovecot::account**

## 0.1.10

* **process_min_avail** is set to the number of CPU cores in the system

## 0.1.9

* added **dovecot-lmtpd** as a default installed package in Ubuntu 14.04 and 16.04

## 0.1.8

* added Ubuntu 16.04 support

## 0.1.7

* added **imap_idle_notify_interval** in minutes using variable **imap_idle_notify_interval_minutes**

## 0.1.4

* ubuntu 14.04 support

## 0.1.3

* bugfix for new installs - bandcamp contribution: https://github.com/NTTCom-MS/eyp-dovecot/pull/3

## 0.1.2

* added dependency for **dovecot::account**

## 0.1.1

* added socket variable for **dovecot::auth::unix-listener**
* base_dir management

## 0.1.0

* initial release
