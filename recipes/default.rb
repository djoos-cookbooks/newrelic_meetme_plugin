#
# Cookbook Name:: newrelic_meetme_plugin
# Recipe:: default
#
# Copyright 2014-2015, Escape Studios
#

include_recipe node['newrelic_meetme_plugin']['python_recipe']

license = node['newrelic_meetme_plugin']['license']

# install latest plugin agent
python_pip node['newrelic_meetme_plugin']['service_name'] do
  if node['newrelic_meetme_plugin']['python_pip_venv']
    virtualenv node['newrelic_meetme_plugin']['python_pip_venv']
  end
  action node['newrelic_meetme_plugin']['python_pip_action']
  if node['newrelic_meetme_plugin']['python_pip_version'] != 'latest'
    version node['newrelic_meetme_plugin']['python_pip_version']
  end
end

# create the configuration, run and log directories,
# making sure they are writable by the user specified in the configuration file
files = [
  node['newrelic_meetme_plugin']['config_file'],
  node['newrelic_meetme_plugin']['pid_file'],
  node['newrelic_meetme_plugin']['log_file']
]

files.each do |file|
  directory ::File.dirname(file) do
    owner node['newrelic_meetme_plugin']['user']
    group node['newrelic_meetme_plugin']['user']
    mode 0755
  end
end

# configuration file
newrelic_meetme_plugin_cfg node['newrelic_meetme_plugin']['config_file'] do
  license license
  wake_interval node['newrelic_meetme_plugin']['wake_interval']
  proxy node['newrelic_meetme_plugin']['proxy']
  services node['newrelic_meetme_plugin']['services']
  user node['newrelic_meetme_plugin']['user']
  pid_file node['newrelic_meetme_plugin']['pid_file']
  log_file node['newrelic_meetme_plugin']['log_file']
  notifies(
    node['newrelic_meetme_plugin']['service_notify_action'],
    "service[#{node['newrelic_meetme_plugin']['service_name']}]",
    :delayed
  )
end

# installing additional requirement(s)
node['newrelic_meetme_plugin']['additional_requirements'].each do |additional_requirement|
  python_pip "newrelic-plugin-agent[#{additional_requirement}]" do
    action :upgrade
  end
end

# init script
variables = {
  :service_name => node['newrelic_meetme_plugin']['service_name'],
  :config_file => node['newrelic_meetme_plugin']['config_file'],
  :pid_file => node['newrelic_meetme_plugin']['pid_file']
}

case node['platform']
when 'debian', 'ubuntu'
  variables[:user] = node['newrelic_meetme_plugin']['user']
  variables[:group] = node['newrelic_meetme_plugin']['user']
end

template "/etc/init.d/#{node['newrelic_meetme_plugin']['service_name']}" do
  source 'newrelic-plugin-agent.erb'
  mode 0755
  variables(
    variables
  )
end

service node['newrelic_meetme_plugin']['service_name'] do
  supports :status => true, :start => true, :stop => true, :restart => true
  action node['newrelic_meetme_plugin']['service_actions']
end
