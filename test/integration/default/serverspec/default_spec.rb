require 'spec_helper'

describe 'New Relic MeetMe Plugin Agent' do
  describe file '/etc/newrelic/newrelic-plugin-agent.cfg' do
    it { is_expected.to be_file }

    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'TESTKEY_PLUGIN_AGENT' }
      it { is_expected.to include 'wake_interval: 60' }
      it { is_expected.to include 'apache_httpd' }
      it { is_expected.to include 'php_apc' }
      it { is_expected.to include 'user: newrelic' }
      it { is_expected.to include 'pidfile: /var/run/newrelic/newrelic-plugin-agent.pid' }
      it { is_expected.to include 'filename: /var/log/newrelic/newrelic-plugin-agent.log' }
    end
  end

  describe service 'newrelic-plugin-agent' do
    it { is_expected.to_not be_running }
    it { is_expected.to be_enabled }
  end
end
