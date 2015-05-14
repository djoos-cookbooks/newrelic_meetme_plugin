# create newrelic user
user 'newrelic' do
  action :create # see actions section below
end

# install the meetme plugin
include_recipe 'python'
include_recipe 'newrelic_meetme_plugin::install'
