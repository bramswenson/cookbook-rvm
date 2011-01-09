action :create do
  ruby, gemset = new_resource.name.split('@')
  gemset ||= 'global'
  rvm_ruby ruby do
    action :install
  end
  rvm_shell "rvm gemset create #{new_resource.name}" do
    action :run
    code %Q{ 
      source /usr/local/lib/rvm
      rvm use #{ruby}@global
      rvm gemset create #{gemset}
    }
    not_if  "rvm list gemsets strings | grep #{ruby} | grep #{gemset}"
  end
end
