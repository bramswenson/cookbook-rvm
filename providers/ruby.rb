# include some helpers to keep resources/providers easy to read
include RvmLibrary

action :install do
  # ensure the system is installed
  rvm 'system' do
    action :install
  end
  # install all the deps for current ruby
  ruby_package_dependencies(new_resource.name).each do |pkg|
    package pkg
  end
  # rvm install ruby via rvm_shell
  rvm_shell "rvm install #{new_resource.name}" do
    action :run
    code   %Q{ rvm install #{new_resource.name} }
    not_if %Q{ rvm list strings | grep "#{new_resource.name}" }
  end
end
