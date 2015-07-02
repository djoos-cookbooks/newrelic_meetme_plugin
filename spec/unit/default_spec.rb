require 'spec_helper'

describe 'newrelic_meetme_plugin::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(:platform => 'ubuntu', :version => '14.04', :step_into => ['newrelic_meetme_plugin']) do |node|
      node.set['newrelic_meetme_plugin']['python_recipe'] = 'python::pip'
      node.set['newrelic_meetme_plugin']['license'] = 'TESTKEY_PLUGIN_AGENT'
      node.set['newrelic']['license'] = 'TESTKEY_PLUGIN_AGENT'
      node.set['newrelic_meetme_plugin']['service_actions'] = [:enable]
      node.set['newrelic_meetme_plugin']['services'] = {
        'apache_httpd' => {
          'scheme' => 'http',
          'host'   => 'localhost',
          'port'   => 80,
          'path'   => '/server-status'
        },
        'php_apc' => {
          'scheme' => 'http',
          'host'   => 'localhost',
          'port'   => 80,
          'path'   => '/apc-nrp.php'
        }
      }
    end.converge described_recipe
  end

  it 'includes the `python::pip` recipe' do
    expect(chef_run).to include_recipe 'python::pip'
  end

  it 'creates newrelic user' do
    expect(chef_run).to create_user('newrelic')
  end

  it 'installs the newrelic_plugin_agent package' do
    expect(chef_run).to install_python_pip 'newrelic-plugin-agent'
  end

  dirs = %w(
    /etc/newrelic
    /var/run/newrelic
    /var/log/newrelic
  )

  dirs.each do |dir|
    it "creates directory #{dir}" do
      expect(chef_run).to create_directory(dir).with(
        :owner => 'newrelic',
        :group => 'newrelic',
        :mode => 0755
      )
    end
  end

  it 'generates newrelic config' do
    expect(chef_run).to create_template('/etc/newrelic/newrelic-plugin-agent.cfg')
  end

  it 'creates /etc/init.d/newrelic-plugin-agent' do
    expect(chef_run).to create_template('/etc/init.d/newrelic-plugin-agent').with(
      :source    => 'newrelic-plugin-agent.erb',
      :mode      => 0755
    )
  end

  it 'enables and starts the newrelic-plugin-agent service' do
    expect(chef_run).to enable_service('newrelic-plugin-agent').with(
      :supports => {
        :status  => true,
        :start   => true,
        :stop    => true,
        :restart => true
      }
    )
    expect(chef_run).to_not start_service 'newrelic-plugin-agent'
  end

  it 'restarts newrelic meetme agent' do
    expect(chef_run).to_not restart_service('restart-newrelic-plugin-agent')
  end
end

describe 'newrelic_meetme_plugin::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['newrelic_meetme_plugin']['python_pip_version'] = '1.2.0'
    end.converge described_recipe
  end
end
