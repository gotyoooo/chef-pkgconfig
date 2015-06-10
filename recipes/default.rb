#
# Cookbook Name:: pkgconfig
# Recipe:: default
# Author:: ken gotoh (lss.ken8927@gmail.com)
#
# Copyright 2015, Ken Gotoh
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

version = node['pkgconfig']['version']
prefix = node['pkgconfig']['prefix']


remote_file "#{Chef::Config[:file_cache_path]}/pkg-config-#{version}.tar.gz" do
  source "http://pkgconfig.freedesktop.org/releases/pkg-config-#{version}.tar.gz"
  not_if {::File.exists?("#{prefix}/lib/pkgconfig")}
  notifies :run, "script[install-pkgconfig]", :immediately
end

script "install-pkgconfig" do
  interpreter "bash"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/pkg-config-#{version}.tar.gz")}
  flags "-e -x"
  code <<-EOH
    cd /usr/local/src
    tar xzf #{Chef::Config[:file_cache_path]}/pkg-config-#{version}.tar.gz
    cd pkg-config-#{version}
    ./configure --prefix=#{prefix}
    make
    make install
  EOH
end

file "pkgconfig-tarball-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/pkg-config-#{version}.tar.gz"
  action :delete
end

