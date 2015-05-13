
# create newrelic user
user 'newrelic' do
  action :create # see actions section below
end

# install the meetme plugin
include_recipe 'python'

newrelic_meetme_plugin 'test' do
  license node['newrelic_meetme_plugin']['license']
  wake_interval 60
  services node['newrelic_meetme_plugin']['services']
  additional_requirements ['mongodb']
end
