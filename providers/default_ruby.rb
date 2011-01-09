action :install do
  rvm_gemset new_resource.name do
    action :create
  end
  rvm_shell "set default_ruby to #{new_resource.name}" do
    action :run
    code %Q{ 
      source /usr/local/lib/rvm
      rvm use #{new_resource.name} --default 
    }
  end
end
