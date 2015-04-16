#
# Cookbook Name:: newrelic_meetme_plugin
# Provider:: cfg
#
# Copyright 2014-2015, Escape Studios
#

require 'yaml'

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :generate do
  services_yml = nil

  services = {
    '#services' => new_resource.services
  }

  services_yml = services.to_yaml(:indentation => 2).gsub(/(! )?['"]#services['"]:/, '#services:').gsub('---', '').gsub(%r{!(ruby\/|map|seq)[a-zA-Z:]*}, '')

  t = template new_resource.cfg_file do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    owner 'root'
    group 'root'
    mode 0644
    variables(
      :license_key => new_resource.license,
      :wake_interval => new_resource.wake_interval,
      :proxy => new_resource.proxy,
      :services_yml => services_yml,
      :user => new_resource.user,
      :pid_file => new_resource.pid_file,
      :log_file => new_resource.log_file
    )
    action :create
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end
