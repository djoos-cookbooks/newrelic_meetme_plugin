require 'spec_helper'

describe 'New Relic MeetMe Plugin Agent' do
  describe file '/etc/newrelic/newrelic-plugin-agent.cfg' do
    it { should_not exist }
  end

  describe service 'newrelic-plugin-agent' do
    it { should_not be_running }
    it { should_not be_enabled }
  end

  describe file '/etc/init.d/newrelic-plugin-agent' do
    it { should_not exist }
  end

  describe user('newrelic') do
    it { should_not exist }
  end
end
