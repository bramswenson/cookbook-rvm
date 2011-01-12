#
# Cookbook Name:: rvm
# Recipe:: system
#
# Copyright 2011, Bram Swenson
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
#

# Install all the packages rvm depends on
pkgs = %w{ sed grep tar gzip bzip2 bash curl }
case node[:platform]
  when "centos","redhat","fedora","suse"
    pkgs << "git"
  when "debian","ubuntu"
    pkgs << "git-core"
end

pkgs.each do |pkg|
  package pkg
end

# Create/update /etc/rvmrc
template "/etc/rvmrc" do
  # setup lines from node[:rvm][:rvmrc] hash
  lines = []
  node[:rvm][:rvmrc] ||= Hash.new
  node[:rvm][:rvmrc].each_pair do |k, v|  
    lines << "#{k.to_s}=#{v.to_s}"
  end
  cookbook "rvm"
  owner    "root"
  group    "rvm"
  mode     "0644"
  # cookbook/templates/default|os-dir-names
  source   "rvmrc.erb"
  # write the lines with erb var
  variables(:lines => lines.sort.join("\n"))
end

# add the profile loader
template "/etc/profile.d/rvm.sh" do
  cookbook "rvm"
  owner    "root"
  group    "rvm"
  mode     "0774"
  source   "rvm.sh.erb"
end

# add all rvm users (project users) to rvm group
group "rvm" do
  members node[:rvm][:users]
  append  true
end

# install rvm
rvm 'system' do
  action :install
end

