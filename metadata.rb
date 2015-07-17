name 'newrelic_meetme_plugin'
maintainer 'Escape Studios'
maintainer_email 'dev@escapestudios.com'
license 'MIT'
description 'Installs/Configures New Relic MeetMe plugin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

%w( debian ubuntu redhat centos fedora scientific amazon windows smartos ).each do |os|
  supports os
end

depends 'python'
depends 'apt'
depends 'yum'

recipe 'newrelic_meetme_plugin', 'Installs the New Relic MeetMe plugin.'
