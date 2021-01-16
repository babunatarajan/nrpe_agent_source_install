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
cp /tmp/nrpe-nrpe-4.0.3/nrpe.cfg /usr/local/nagios/etc/nrpe.cfg
