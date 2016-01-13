if defined?(ChefSpec)
  ChefSpec.define_matcher :newrelic_meetme_plugin_cfg

  def install_newrelic_meetme_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_meetme_plugin, :install, name)
  end

  def generate_newrelic_meetme_plugin_cfg(config_file)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_meetme_plugin_cfg, :generate, config_file)
  end
end
