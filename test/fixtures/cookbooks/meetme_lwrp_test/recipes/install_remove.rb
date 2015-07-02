# install the meetme plugin
include_recipe 'python::pip'

newrelic_meetme_plugin 'test' do
  license node['newrelic_meetme_plugin']['license']
  wake_interval 60
  services node['newrelic_meetme_plugin']['services']
  additional_requirements ['mongodb']
end

newrelic_meetme_plugin 'test' do
  action :remove
end
