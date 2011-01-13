actions :install

attribute :cwd,  :kind_of => String, :name_attribute => true
attribute :ruby, :kind_of => String, :default => 'default'
attribute :user, :kind_of => String
attribute :ssh_wrapper, :kind_of => String
