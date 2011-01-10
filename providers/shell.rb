action :run do
  script new_resource.name do
    # use the rvm provided shell wrapper
    interpreter "/usr/local/bin/rvm-shell"
    code %Q{
      # load the profile so we are sure rvm intact
      source /etc/profile.d/rvm.sh
      # use the ruby we are told to, default to default
      rvm use #{new_resource.ruby}
      # run either the command or code input (not both)
      #{new_resource.code ? new_resource.code : new_resource.command }
    }
  end
end
