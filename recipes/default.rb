#
# Cookbook Name:: newrelic_meetme_plugin
# Recipe:: default
#
# Copyright 2014-2015, Escape Studios
#

include_recipe node['newrelic_meetme_plugin']['python_recipe']

newrelic_meetme_plugin 'default' do
  license node['newrelic_meetme_plugin']['license']
  version node['newrelic_meetme_plugin']['python_pip_version'] if node['newrelic_meetme_plugin']['python_pip_version'] != 'latest'
  virtualenv node['newrelic_meetme_plugin']['python_pip_venv'] if node['newrelic_meetme_plugin']['python_pip_venv']
  config_file node['newrelic_meetme_plugin']['config_file'] if node['newrelic_meetme_plugin']['config_file']
  wake_interval node['newrelic_meetme_plugin']['wake_interval'] if node['newrelic_meetme_plugin']['wake_interval']
  proxy node['newrelic_meetme_plugin']['proxy'] if node['newrelic_meetme_plugin']['proxy']
  services node['newrelic_meetme_plugin']['services'] if node['newrelic_meetme_plugin']['services']
  additional_requirements node['newrelic_meetme_plugin']['additional_requirements'] if node['newrelic_meetme_plugin']['additional_requirements']
  prefix node['newrelic_meetme_plugin']['prefix'] if node['newrelic_meetme_plugin']['prefix']
  service_name node['newrelic_meetme_plugin']['service_name'] if node['newrelic_meetme_plugin']['service_name']
  service_actions node['newrelic_meetme_plugin']['service_actions'] if node['newrelic_meetme_plugin']['service_actions']
  user node['newrelic_meetme_plugin']['user'] if node['newrelic_meetme_plugin']['user']
  pid_file node['newrelic_meetme_plugin']['pid_file'] if node['newrelic_meetme_plugin']['pid_file']
  log_file node['newrelic_meetme_plugin']['log_file'] if node['newrelic_meetme_plugin']['log_file']
end
