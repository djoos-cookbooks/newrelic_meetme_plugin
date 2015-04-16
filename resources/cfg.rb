#
# Cookbook Name:: newrelic_meetme_plugin
# Resource:: cfg
#
# Copyright 2014-2015, Escape Studios
#

actions :generate
default_action :generate

attribute :cfg_file, :kind_of => String, :name_attribute => true
attribute :template_cookbook, :kind_of => String, :default => 'newrelic_meetme_plugin'
attribute :template_source, :kind_of => String, :default => 'newrelic-plugin-agent.cfg.erb'
attribute :license, :kind_of => String, :default => node['newrelic_meetme_plugin']['license']
attribute :wake_interval, :kind_of => Integer, :default => node['newrelic_meetme_plugin']['wake_interval']
attribute :proxy, :kind_of => String, :default => node['newrelic_meetme_plugin']['proxy']
attribute :services, :kind_of => Hash, :default => nil
attribute :user, :kind_of => String, :default => node['newrelic_meetme_plugin']['user']
attribute :pid_file, :kind_of => String, :default => node['newrelic_meetme_plugin']['pid_file']
attribute :log_file, :kind_of => String, :default => node['newrelic_meetme_plugin']['log_file']
