name 'newrelic_meetme_plugin'
maintainer 'David Joos'
maintainer_email 'development@davidjoos.com'
license 'MIT'
description 'Installs/Configures New Relic MeetMe plugin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.5.0'

%w(debian ubuntu redhat centos fedora scientific amazon windows smartos).each do |os|
  supports os
end

source_url 'https://github.com/djoos-cookbooks/newrelic_meetme_plugin' if respond_to?(:source_url)
issues_url 'https://github.com/djoos-cookbooks/newrelic_meetme_plugin/issues' if respond_to?(:issues_url)

depends 'python'
depends 'apt'
depends 'yum'

recipe 'newrelic_meetme_plugin', 'Installs the New Relic MeetMe plugin.'
