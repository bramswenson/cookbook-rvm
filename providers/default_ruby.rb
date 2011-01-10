action :install do
  # ensure the gemset/ruby exist that we want to default
  rvm_gemset new_resource.name do
    action :create
  end
  # set the default ruby
  rvm_shell "set default_ruby to #{new_resource.name}" do
    action :run
    code %Q{ rvm use #{new_resource.name} --default }
  end
end
