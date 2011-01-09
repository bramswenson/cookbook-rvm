action :run do
  script new_resource.name do
    interpreter "/usr/local/bin/rvm-shell"
    if new_resource.code
      code new_resource.code
    else
      command new_resource.command
    end
  end
end
