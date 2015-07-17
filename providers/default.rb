#
# Cookbook Name:: newrelic_meetme_plugin
# Provider:: newrelic_meetme_plugin_install
#
# Copyright 2012-2015, Escape Studios
#

# include helper methods
include NewRelicMeetMePlugin::Helpers

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :nothing do
end

action :install do
  # Check license key provided
  check_license
  fail 'Cannot install newrelic meetme plugin. Missing pip. Please ensure python and pip are installed before calling this resource.' unless pip_installed?
  converge_by("Install #{@new_resource}.") do
    user_manage('create')
    create_files
    meetme_action(:install)
    generate_config
    new_resource.additional_requirements.each do |package|
      meetme_additional_package(package)
    end
    init_service
  end
end

action :remove do
  converge_by("Delete #{@new_resource}. Remove pip package and config file.") do
    remove_service
    meetme_action(:remove)
    user_manage('remove')
  end
end

def generate_config
  services_yml = nil
  services = {
    '#services' => new_resource.services
  }
  services_yml = services.to_yaml(:indentation => 2).gsub(/(! )?['"]#services['"]:/, '#services:').gsub('---', '').gsub(%r{!(ruby\/|map|seq)[a-zA-Z:]*}, '')

  # service restart
  service 'restart-newrelic-plugin-agent' do
    service_name new_resource.service_name
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:nothing]
  end
  t = template new_resource.config_file do
    cookbook new_resource.cookbook
    source new_resource.source
    owner 'root'
    group 'root'
    mode 0644
    variables(
      :resource => new_resource,
      :services_yml => services_yml
    )
    action :create
    notifies :restart, 'service[restart-newrelic-plugin-agent]', :delayed
  end
end

def create_files
  files = [new_resource.config_file, new_resource.pid_file, new_resource.log_file]
  files.each do |file|
    directory ::File.dirname(file) do
      owner new_resource.user
      group new_resource.user
      mode 0755
    end
  end
end

def meetme_action(action)
  python_pip 'newrelic-plugin-agent' do
    virtualenv new_resource.virtualenv if new_resource.virtualenv
    version new_resource.version if new_resource.version
    action action
  end

  delete_config if action == :remove
end

def delete_config
  file new_resource.config_file do
    action :delete
  end
end

def meetme_additional_package(package)
  python_pip "newrelic-plugin-agent[#{package}]" do
    action :upgrade
  end
end

def user_manage(action)
  user new_resource.user do
    action action
  end
end

def remove_service
  service new_resource.service_name do
    action [:stop, :disable]
  end
  file "/etc/init.d/#{new_resource.service_name}" do
    action :delete
  end
end

def init_service
  template "/etc/init.d/#{new_resource.service_name}" do
    cookbook 'newrelic_meetme_plugin'
    source 'newrelic-plugin-agent.erb'
    mode 0755
    variables(
      :resource => new_resource.to_hash
    )
  end

  service new_resource.service_name do
    supports :status => true, :start => true, :stop => true, :restart => true
    action new_resource.service_actions
  end
end
