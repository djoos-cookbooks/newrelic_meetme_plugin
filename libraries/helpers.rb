# NewRelic helpers
module NewRelic
  # helpers module
  module Helpers
    def newrelic_repository
      install_newrelic_repo
    end

    def check_license
      # check license key provided
      fail 'The NewRelic key is required.' if new_resource.license.nil?
    end

    def install_newrelic_repo
      install_newrelic_repo_debian if node['platform_family'] == 'debian'
      install_newrelic_repo_rhel if node['platform_family'] == ('rhel' || 'fedora')
    end

    # rubocop:disable AbcSize
    def install_newrelic_repo_debian
      apt_repository 'newrelic' do
        uri node['newrelic']['repository']['uri']
        distribution node['newrelic']['repository']['distribution']
        components node['newrelic']['repository']['components']
        key node['newrelic']['repository']['key']
      end
    end
    # rubocop:enable AbcSize

    def install_newrelic_repo_rhel
      yum_repository 'newrelic' do
        description 'New Relic packages for Enterprise Linux 5 - $basearch'
        baseurl node['newrelic']['repository']['uri']
        gpgkey node['newrelic']['repository']['key']
      end
    end

    def directory_exists?(dir)
      return false unless ::File.exist?(dir)
      true
    end

    def user_exists?(user)
      # check if npm is installed
      cmd = Mixlib::ShellOut.new('id ' + user)
      cmd.run_command
      return true unless cmd.error?
      false
    end

    def pip_installed?
      # check if npm is installed
      cmd = Mixlib::ShellOut.new('which pip')
      cmd.run_command
      return true unless cmd.error?
      false
    end
  end
end
