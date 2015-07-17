# NewRelicMeetMePlugin helpers
module NewRelicMeetMePlugin
  # helpers module
  module Helpers
    def check_license
      # check license key provided
      fail 'The New Relic key is required.' if new_resource.license.nil?
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
