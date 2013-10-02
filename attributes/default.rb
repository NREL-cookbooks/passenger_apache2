default['passenger']['install_method'] = 'source'

default['passenger']['version']     = '3.0.19'
default['passenger']['apache_mpm']  = nil
default['passenger']['root_path']   = "#{languages['ruby']['gems_dir']}/gems/passenger-#{passenger['version']}"
default['passenger']['module_path'] = "#{passenger['root_path']}/ext/apache2/mod_passenger.so"
default['passenger']['max_pool_size'] = 6
default['passenger']['manage_module_conf'] = true
default['passenger']['package']['name'] = nil
# set package version to nil, the distro package may not be the same version
default['passenger']['package']['version'] = nil
default['passenger']['ruby_bin'] = languages['ruby']['ruby_bin']

# General
default[:passenger][:spawn_method] = "smart-lv2"
default[:passenger][:use_global_queue] = true

# Security
default[:passenger][:user_switching] = true
default[:passenger][:default_user] = "nobody"
default[:passenger][:default_group] = nil
default[:passenger][:friendly_error_pages] = true

# Resource control and optimization
default[:passenger][:min_instances] = 1
default[:passenger][:max_instances_per_app] = 0
default[:passenger][:pool_idle_time] = 300
default[:passenger][:max_requests] = 0
default[:passenger][:max_preloader_idle_time] = 300
default[:passenger][:stat_throttle_rate] = 0
default[:passenger][:pre_start_urls] = []
default[:passenger][:high_performance] = false

# Compatibility
default[:passenger][:resolve_symlinks_in_document_root] = false
default[:passenger][:allow_encoded_slashes] = false

# Logging and debugging
default[:passenger][:log_level] = 0
default[:passenger][:debug_log_file] = nil

# Ruby on Rails-specific
default[:passenger][:rails_auto_detect] = true
default[:passenger][:rails_base_uri] = nil
default[:passenger][:rails_env] = "production"
default[:passenger][:rails_framework_spawner_idle_time] = 1800
default[:passenger][:rails_app_spawner_idle_time] = 600

# Rack-specific
default[:passenger][:rack_auto_detect] = true
default[:passenger][:rack_base_uri] = nil
default[:passenger][:rack_env] = "production"
