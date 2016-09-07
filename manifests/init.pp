# == Class: med12315
#
# Full description of class med12315 here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'med12315':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# ponsfrilus <nicolas.borboen@epfl.ch>
#
# === Copyright
#
# Copyright 2016 Nicolas Borboen (EPFL)
#

class med12315(
	$sudoer_group = "sti-it"
) {
	include sudo
	
	# todo => sti-it should be a params
	sudo::conf { 'sti-it':
		ensure  => present,
		content => "%$sudoer_group ALL=(ALL) NOPASSWD: ALL",
	}

	class { 'epfl_sso' :
		allowed_users_and_groups => "nborboen ($sudoer_group) (med12315_admins)"
	}

	file { '/etc/lightdm/lightdm.conf' :
		ensure	=> present,
		content => template('med12315/lightdm.conf.erb'),
		owner	=> root,
		group	=> root,
		mode 	=> '0644'
	}

}
