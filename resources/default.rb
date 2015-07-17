#
# Cookbook Name:: newrelic_meetme_plugin
# Resource: newrelic_meetme_plugin_install
#
# Copyright 2012-2015, Escape Studios
#

actions :install, :remove
default_action :install

attribute :license, :kind_of => String, :required => true, :default => nil
attribute :version, :kind_of => String, :default => nil
attribute :virtualenv, :kind_of => String, :default => nil
attribute :config_file, :kind_of => String, :default => '/etc/newrelic/newrelic-plugin-agent.cfg'
attribute :cookbook, :kind_of => String, :default => 'newrelic_meetme_plugin'
attribute :source, :kind_of => String, :default => 'newrelic-plugin-agent-cfg.erb'
attribute :wake_interval, :kind_of => Integer, :default => 60
attribute :proxy, :kind_of => String, :default => nil
attribute :services, :kind_of => Hash, :default => nil
attribute :additional_requirements, :kind_of => Array, :default => [] # eg. ['mongodb', 'pgbouncer']
attribute :prefix, :kind_of => String, :default => '/usr/bin'
attribute :service_name, :kind_of => String, :default => 'newrelic-plugin-agent'
attribute :service_actions, :kind_of => Array, :default => [:enable, :start]
attribute :user, :kind_of => String, :default => 'newrelic'
attribute :pid_file, :kind_of => String, :default => '/var/run/newrelic/newrelic-plugin-agent.pid'
attribute :log_file, :kind_of => String, :default => '/var/log/newrelic/newrelic-plugin-agent.log'
