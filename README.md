### About

This Docker image use `chrony` as the Network Time Protocol (NTP) server.  

**What is chrony?**

`chrony` is a versatile implementation of the Network Time Protocol (NTP) - https://chrony.tuxfamily.org/


### Example

```
s6-rc: info: service s6rc-oneshot-runner: starting
s6-rc: info: service s6rc-oneshot-runner successfully started
s6-rc: info: service fix-attrs: starting
s6-rc: info: service chrony-config: starting
s6-rc: info: service fix-attrs successfully started
s6-rc: info: service legacy-cont-init: starting
s6-rc: info: service chrony-config successfully started
s6-rc: info: service chrony: starting
s6-rc: info: service legacy-cont-init successfully started
 ____                            _ _             
/ ___|  ___  _ __ __ _ _ __ ___ (_) |_ ___ _   _ 
\___ \ / _ \| '__/ _` | '_ ` _ \| | __/ __| | | |
 ___) | (_) | | | (_| | | | | | | | |_\__ \ |_| |
|____/ \___/|_|  \__,_|_| |_| |_|_|\__|___/\__,_|
                                                 
Network Time Protocol

s6-rc: info: service chrony successfully started
s6-rc: info: service legacy-services: starting
2022-10-31T15:06:57Z chronyd version 4.2 starting (+CMDMON +NTP +REFCLOCK +RTC +PRIVDROP -SCFILTER +SIGND +ASYNCDNS +NTS +SECHASH +IPV6 -DEBUG)
2022-10-31T15:06:57Z Disabled control of system clock
2022-10-31T15:06:57Z Could not read valid frequency and skew from driftfile /var/lib/chrony/chrony.drift
s6-rc: info: service legacy-services successfully started
2022-10-31T15:07:01Z Selected source 162.159.200.123 (time.cloudflare.com)
```
