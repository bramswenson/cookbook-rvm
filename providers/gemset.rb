include RvmLibrary

action :create do
  # split the ruby and gemset
  ruby, gemset = split_ruby_gemset(new_resource.name)
  # install the ruby
  rvm_ruby ruby do
    action :install
  end
  # create the gemset
  rvm_shell "rvm gemset create #{new_resource.name}" do
    action :run
    ruby "#{ruby}@global" # this is how we say the ruby to use
    code %Q{ rvm gemset create #{gemset} }
    not_if  %Q{ rvm list gemsets strings | grep "#{ruby}" | egrep "#{gemset}$" }
  end
end
