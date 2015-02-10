if defined?(ChefSpec)
  ChefSpec.define_matcher :newrelic_meetme_plugin_cfg

  def generate_newrelic_meetme_plugin_cfg(config_file)
    ChefSpec::Matchers::ResourceMatcher.new(:newrelic_meetme_plugin_cfg, :generate, config_file)
  end
end
