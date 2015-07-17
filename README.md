[![Build Status](https://travis-ci.org/escapestudios-cookbooks/newrelic_meetme_plugin.png)](https://travis-ci.org/escapestudios-cookbooks/newrelic_meetme_plugin)

# newrelic_meetme_plugin cookbook

## Description

This cookbook provides an easy way to install various New Relic agents and the New Relic server monitor.

More information?

* https://pypi.python.org/pypi/newrelic-plugin-agent
* https://github.com/MeetMe/newrelic-plugin-agent#installation-instructions

## Requirements

### Chef version:

Make sure you run Chef >= 0.10.0.

### Cookbooks:

* python

### Platforms:

* Debian
* Ubuntu
* RHEL
* CentOS
* Fedora
* Scientific
* Amazon
* Windows
* SmartOS

## Attributes

### default.rb:

* `node['newrelic_meetme_plugin']['license']` - Your New Relic license key. Default is `nil`
* `node['newrelic_meetme_plugin']['python_recipe']` - The python recipe to include, defaults to 'python::pip'
* `node['newrelic_meetme_plugin']['python_pip_action']` - The action on pip, defaults to 'install'
* `node['newrelic_meetme_plugin']['python_pip_version']` - The pip version to action, defaults to 'latest'
* `node['newrelic_meetme_plugin']['python_pip_venv']` - The pip virtual environment, optional
* `node['newrelic_meetme_plugin']['service_name']` - The New Relic MeetMe plugin service name, defaults to 'newrelic-plugin-agent'
* `node['newrelic_meetme_plugin']['service_actions']` - The New Relic MeetMe plugin service actions, defaults to "[:enable, :start]" (#starts the service if it's not running and enables it to start at system boot time)
* `node['newrelic_meetme_plugin']['wake_interval']` - The New Relic plugin agent wake interval, defaults to 60
* `node['newrelic_meetme_plugin']['proxy']` - The New Relic plugin agent proxy, optional
* `node['newrelic_meetme_plugin']['services']` - A hash of New Relic MeetMe plugin services, defaults to nil

eg.
```
{
  'memcached' => {
    'name' => 'localhost',
    'host' => 'host',
    'port' => 11211
  },
  'redis' => [
    {
      'name' => 'localhost',
      'host' => 'localhost',
      'port' => 6379,
      'db_count' => 16,
      'password' => 'foobar'
    },
    {
      'name' => 'localhost',
      'host' => 'localhost',
      'port' => 6380,
      'db_count' => 16,
      'password' => 'foobar'
    }
  ]
}
```
* `node['newrelic_meetme_plugin']['config_file']` - The New Relic plugin agent config file, defaults to "/etc/newrelic/newrelic-plugin-agent.cfg"
* `node['newrelic_meetme_plugin']['pid_file']` - The New Relic plugin agent PID file name, defaults to "/var/run/newrelic/newrelic-plugin-agent.pid"
* `node['newrelic_meetme_plugin']['log_file']` - The New Relic plugin agent log file name, defaults to "/var/log/newrelic/newrelic-plugin-agent.log"
* `node['newrelic_meetme_plugin']['user']` - The New Relic plugin agent user, defaults to "newrelic".
* `node['newrelic_meetme_plugin']['additional_requirements']` - The New Relic plugin agent's additional requirements, eg. ["mongodb", "pgbouncer", "postgresql"] - defaults to []

## Usage

There are two ways to use this cookbook: the LWRP resource or the default recipe.

### default recipe:

1. include `recipe[newrelic_meetme_plugin]`
2. change the `node['newrelic_meetme_plugin']['license']` attribute to your New Relic license key
--- OR ---
override the attributes on a higher level (http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

### newrelic_meetme_plugin lwrp:

The `newrelic_meetme_plugin` resource will install or remove the plugin and populate the config file.  See test/fixtures/cookbooks/meetme_lwrp_test/recipes/install.rb for an example.

##### Prerequisites
* Python and Pip need to be installed

##### Actions

- :install - Install the meetme plugin package and populate config.  
- :remove  -  Uninstall the meetme plugin package and remove config

##### Attribute parameters

* `'license'` New Relic license key
* `'virtualenv'` the python virtualenv to install the pip package into
* `'config_file'` the path to config file. Default '/etc/newrelic/newrelic-plugin-agent.cfg'
* `'cookbook'` - Sets cookbook for template, defaults to this cookbook newrelic_meetme_plugin.
* `'source'` - Sets source for template, defaults to 'newrelic-plugin-agent-cfg.erb'
* `'wake_interval'`- The New Relic plugin agent wake interval, defaults to 60
* `'proxy'`- The New Relic plugin agent proxy, optional
* `'services'`- A hash of services to monitor. See Attributes. Default empty hash.
* `'additional_requirements'`- The New Relic plugin agent's additional requirements, eg. ["mongodb", "pgbouncer", "postgresql"] - defaults to []
* `'service_name'`- The New Relic MeetMe plugin service name, defaults to 'newrelic-plugin-agent'
* `'user'`- Defaults to 'newrelic'.  This user is not created by the cookbook or the PyPi package, so the default value will cause the plugin agent to fail if the `newrelic` user does not exist.
* `'pid_file'`- The New Relic plugin agent PID file name, defaults to "/var/run/newrelic/newrelic-plugin-agent.pid"
* `'log_file'`- The New Relic plugin agent log file name, defaults to "/var/log/newrelic/newrelic-plugin-agent.log"

## License and Authors

Author: David Joos <david.joos@escapestudios.com>
Author: Escape Studios Development <dev@escapestudios.com>
Copyright: 2014-2015, Escape Studios

Unless otherwise noted, all files are released under the MIT license,
possible exceptions will contain licensing information in them.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
