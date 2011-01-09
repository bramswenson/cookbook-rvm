action :install do
  rvm 'system' do
    action :install
  end
  rvm_shell "rvm install #{new_resource.name}" do
    action :run
    code   "rvm install #{new_resource.name}"
    not_if "rvm list strings | grep #{new_resource.name}"
  end
end
