#!/bin/bash
# Source: https://raw.githubusercontent.com/epfl-sti/puppet.med12315/master/install.sh 
# Run:
# curl -sL https://raw.githubusercontent.com/epfl-sti/puppet.med12315/master/install.sh | sudo bash -

set -x
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

apt install -y puppet
cd /etc/puppet/modules/
git clone https://github.com/epfl-sti/puppet.med12315.git med12315
puppet module install saz-sudo
puppet module install domq/epfl_sso
puppet apply  -e 'class { "med12315": sudoer_group => sti-it} '

service sssd restart
service lightdm restart
