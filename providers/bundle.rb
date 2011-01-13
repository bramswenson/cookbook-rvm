action :install do
  codez = new_resource.ssh_wrapper.nil? ? '' : %Q{ export GIT_SSH=#{new_resource.ssh_wrapper} ; } 
  rvm_shell "bundle install in #{new_resource.name}" do
    action :run
    user new_resource.user if new_resource.user
    ruby new_resource.ruby
    code %Q{ #{codez}cd #{new_resource.name} && bundle install }
  end
end
