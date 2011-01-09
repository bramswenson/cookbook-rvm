action :run do
  script new_resource.name do
    interpreter "/usr/local/bin/rvm-shell"
    code %Q{
      source /etc/profile.d/rvm.sh
      rvm use #{ruby}
      #{new_resource.code ? new_resource.code : new_resource.command }
    }
  end
end
