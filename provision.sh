#!/bin/bash

# Install basic packages
echo "Installing packages"
apt-get update
apt-get -y dist-upgrade
apt-get -y install \
	build-essential git nodejs npm \
	libglib2.0-dev graphviz \
  libcurl4-openssl-dev libssl-dev
	
# Environment fixups
echo "Environment fixups"
[ -d "/data" ] || mkdir /data
[ -f "/usr/bin/node" ] || ln -s /usr/bin/nodejs /usr/bin/node

# PostgreSQL 9.6
echo "Configuring postgresql"
if [ ! -f "/etc/apt/sources.list.d/postgresql.list" ] ; then
 echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/postgresql.list
 wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
 apt-get update
fi

apt-get -y install postgresql-9.6
sed -i.bak '/^local/ s/peer/trust/' /etc/postgresql/9.6/main/pg_hba.conf 
sed -i.bak -r '/^#?listen_addresses/ { s/^#//; s/localhost/*/ }' /etc/postgresql/9.6/main/postgresql.conf
pg_ctlcluster 9.6 main restart

echo "Setting up rbenv and Ruby"
( cd /home/vagrant/rails-simple-socialnet && \
  sudo -u vagrant -H make all SSN_RBENV_ROOT=/home/vagrant )
