require 'spec_helper'

describe 'newrelic_meetme_plugin::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(:platform => 'ubuntu', :version => '14.04') do |node|
      node.set['newrelic_meetme_plugin']['service_actions'] = :enable
    end.converge described_recipe
  end

  it 'enables, but does not start, the newrelic-plugin-agent service' do
    expect(chef_run).to enable_service 'newrelic-plugin-agent'
    expect(chef_run).to_not start_service 'newrelic-plugin-agent'
  end
end
