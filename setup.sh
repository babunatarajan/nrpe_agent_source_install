#!/usr/bin/env bash

service nagios-nrpe-server stop
apt -y remove nagios-nrpe-server
apt-get -y install build-essential libssl-dev

cd /tmp/nrpe_agent_source_install
wget --no-check-certificate -O nrpe.tar.gz https://github.com/NagiosEnterprises/nrpe/archive/nrpe-4.0.3.tar.gz
tar xzf nrpe.tar.gz

cd /tmp/nrpe_agent_source_install/nrpe-nrpe-4.0.3/
./configure --enable-command-args
make all
make install-groups-users
make install
make install-config
make install-init
update-rc.d nrpe defaults
cp /tmp/nrpe_agent_source_install/nrpe.cfg /usr/local/nagios/etc/nrpe.cfg
cp /tmp/nrpe_agent_source_install/check_memory /usr/local/nagios/libexec/check_mem
service nrpe start
netstat -tupln | grep 5666

#Install the Nagios Plugins
export VER="2.3.3"
curl -SL https://github.com/nagios-plugins/nagios-plugins/releases/download/release-$VER/nagios-plugins-$VER.tar.gz | tar -xzf -
cd nagios-plugins-$VER
   ./configure --with-nagios-user=nagios --with-nagios-group=nagios
   make
   sudo make install
