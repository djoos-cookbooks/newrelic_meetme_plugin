require 'spec_helper'

describe 'newrelic_meetme_plugin::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
end
