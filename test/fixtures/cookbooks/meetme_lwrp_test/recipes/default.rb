#
# Cookbook Name:: newrelic_meetme_plugin
# Recipe:: default
#
# Copyright 2014-2015, Escape Studios
#

# create newrelic user
user 'newrelic' do
  action :create # see actions section below
end

include_recipe 'newrelic_meetme_plugin::default'
