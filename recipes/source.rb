#
# Cookbook Name:: passenger_apache2
# Recipe:: source
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "build-essential"

node.default['passenger']['apache_mpm']  = 'prefork'

# Allows proper default path if root path was overridden
passenger_module_dir_name = node['passenger']['version'].start_with?('4') ? 'buildout' : 'ext'
node.default['passenger']['root_path']   = "#{node['languages']['ruby']['gems_dir']}/gems/passenger-#{node['passenger']['version']}"
node.default['passenger']['module_path'] = "#{node['passenger']['root_path']}/#{passenger_module_dir_name}/apache2/mod_passenger.so"

case node['platform_family']
when "arch"
  package "apache"
when "rhel"
  package "httpd-devel"
  if node['platform_version'].to_f < 6.0
    package 'curl-devel'
  else
    package 'libcurl-devel'
    package 'openssl-devel'
    package 'zlib-devel'
  end
else
  apache_development_package =  if %w( worker threaded ).include? node['passenger']['apache_mpm']
                                  'apache2-threaded-dev'
                                else
                                  'apache2-prefork-dev'
                                end
  %W( #{apache_development_package} libapr1-dev libcurl4-gnutls-dev ).each do |pkg|
    package pkg do
      action :upgrade
    end
  end
end

rbenv_gem "passenger" do
  version node['passenger']['version']

  if node[:passenger][:rbenv_version]
    rbenv_version node[:passenger][:rbenv_version]
  end
end

execute "passenger_module" do
  command "passenger-install-apache2-module _#{node['passenger']['version']}_ --auto"
  creates node['passenger']['module_path']
end
