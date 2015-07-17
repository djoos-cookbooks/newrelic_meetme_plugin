#
# Cookbook Name:: newrelic_meetme_plugin
# Attributes:: default
#
# Copyright 2014-2015, Escape Studios
#

default['newrelic_meetme_plugin']['license'] = nil
default['newrelic_meetme_plugin']['python_recipe'] = 'python::pip'
default['newrelic_meetme_plugin']['python_pip_action'] = :install
default['newrelic_meetme_plugin']['python_pip_version'] = 'latest'
default['newrelic_meetme_plugin']['python_pip_venv'] = nil
default['newrelic_meetme_plugin']['prefix'] = '/usr/bin'
default['newrelic_meetme_plugin']['service_name'] = 'newrelic-plugin-agent'
default['newrelic_meetme_plugin']['service_actions'] = [:enable, :start]
default['newrelic_meetme_plugin']['service_notify_action'] = :restart
default['newrelic_meetme_plugin']['wake_interval'] = 60
default['newrelic_meetme_plugin']['proxy'] = nil
default['newrelic_meetme_plugin']['services'] = {}
default['newrelic_meetme_plugin']['config_file'] = '/etc/newrelic/newrelic-plugin-agent.cfg'
default['newrelic_meetme_plugin']['pid_file'] = '/var/run/newrelic/newrelic-plugin-agent.pid'
default['newrelic_meetme_plugin']['log_file'] = '/var/log/newrelic/newrelic-plugin-agent.log'
default['newrelic_meetme_plugin']['user'] = 'newrelic'
default['newrelic_meetme_plugin']['additional_requirements'] = []
