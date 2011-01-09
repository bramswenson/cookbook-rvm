action :run do
  script new_resource.name do
    interpreter "/usr/local/bin/rvm-shell"
    if new_resource.code
      codez = new_resource.code
    else
      codez = new_resource.command
    end
    code %Q{
      source /etc/profile.d/rvm.sh
      rvm use #{ruby}
      #{codez}
    }
  end
end
