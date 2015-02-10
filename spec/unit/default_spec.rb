require 'spec_helper'

describe 'newrelic_meetme_plugin::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(:platform => 'ubuntu', :version => '14.04') do |node|
      node.set['newrelic_meetme_plugin']['license'] = 'TESTKEY_PLUGIN_AGENT'
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

  it 'creates the New Relic Plugin Agent config' do
    expect(chef_run).to generate_newrelic_meetme_plugin_cfg('/etc/newrelic/newrelic-plugin-agent.cfg')
      .with(
        :license       => 'TESTKEY_PLUGIN_AGENT',
        :wake_interval => 60,
        :services      => {
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
        },
        :user     => 'newrelic',
        :pid_file => '/var/run/newrelic/newrelic-plugin-agent.pid',
        :log_file => '/var/log/newrelic/newrelic-plugin-agent.log'
      )
    cfg = chef_run.newrelic_meetme_plugin_cfg('/etc/newrelic/newrelic-plugin-agent.cfg')
    expect(cfg).to notify('service[newrelic-plugin-agent]').delayed
  end

  it 'creates /etc/init.d/newrelic-plugin-agent' do
    expect(chef_run).to create_template('/etc/init.d/newrelic-plugin-agent').with(
      :source    => 'newrelic-plugin-agent.erb',
      :mode      => 0755,
      :variables => {
        :service_name => 'newrelic-plugin-agent',
        :config_file  => '/etc/newrelic/newrelic-plugin-agent.cfg',
        :pid_file     => '/var/run/newrelic/newrelic-plugin-agent.pid',
        :user         => 'newrelic',
        :group        => 'newrelic'
      }
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
    expect(chef_run).to start_service 'newrelic-plugin-agent'
  end
end

describe 'newrelic_meetme_plugin::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['newrelic_meetme_plugin']['python_pip_version'] = '1.2.0'
    end.converge described_recipe
  end

  it 'installs v1.2.0 of newrelic_meetme_plugin' do
    expect(chef_run).to install_python_pip('newrelic-plugin-agent')
      .with :version => '1.2.0'
  end
end

describe 'newrelic_meetme_plugin::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(:platform => 'ubuntu', :version => '14.04') do |node|
      node.set['newrelic_meetme_plugin']['service_actions'] = :enable
    end.converge described_recipe
  end

  it 'enables, but does not start, the newrelic-plugin-agent service' do
    expect(chef_run).to enable_service 'newrelic-plugin-agent'
    expect(chef_run).to_not start_service 'newrelic-plugin-agent'
  end
end
