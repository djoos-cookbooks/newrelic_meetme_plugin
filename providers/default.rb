#
# Cookbook Name:: newrelic
# Provider:: newrelic_meetme_plugin_install
#
# Copyright 2012-2015, Escape Studios
#

# include helper methods
include NewRelic::Helpers

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
  fail "Cannot install newrelic meetme plugin. Please ensure user #{new_resource.user} exists before calling the resource." unless user_exists?(new_resource.user)
  create_files
  meetme_action(:install)
  generate_config
  new_resource.additional_requirements.each do |package|
    meetme_additional_package(package)
  end
  init_service
end

action :remove do
  meetme_action(:remove)
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
  new_resource.updated_by_last_action(t.updated_by_last_action?)
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
  ::File.delete(new_resource.config_file) if ::File.exist?(new_resource.config_file)
end

def meetme_additional_package(package)
  python_pip "newrelic-plugin-agent[#{package}]" do
    action :upgrade
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
    action [:enable, :start]
  end
end
