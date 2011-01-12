action :install do
  rvm_shell "bundle install in #{new_resource.name}" do
    action :run
    ruby new_resource.ruby
    code %Q{ cd #{new_resource.name} && bundle install }
  end
end
