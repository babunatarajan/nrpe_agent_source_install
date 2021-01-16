#!/usr/bin/env bash

service nagios-nrpe-server stop
apt -y remove nagios-nrpe-server
apt -y remove nagios-nrpe-server
cd /tmp
wget --no-check-certificate -O nrpe.tar.gz https://github.com/NagiosEnterprises/nrpe/archive/nrpe-4.0.3.tar.gz
tar xzf nrpe.tar.gz

cd /tmp/nrpe-nrpe-4.0.3/
./configure --enable-command-args
make all
make install-groups-users
make install
make install-config
make install-init
update-rc.d nrpe defaults
cd /tmp/nrpe_agent_source_install
cp /tmp/nrpe_agent_source_install/nrpe.cfg /usr/local/nagios/etc/nrpe.cfg
cp /tmp/nrpe_agent_source_install/check_memory /usr/local/nagios/libexec/check_memory
service nagios-nrpe-server start
netstat -tupln | grep 5666

