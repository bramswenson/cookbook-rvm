action :install do
  rubies = new_resource.ruby.kind_of?(Array) ? new_resource.ruby : [ new_resource.ruby ]
  gems   = new_resource.name.kind_of?(Array) ? new_resource.name : [ new_resource.name ]
  rubies.each do |ruby|
    rvm_gemset ruby do
      action :create
    end
    gems.each do |gem|
      gem_package gem do
        action       :install
        gem_binary   "rvm #{ruby} gem"
        source new_resource.source  if new_resource.source
        version new_resource.version if new_resource.version
      end
    end
  end
  bash "update rvm perms" do
    code %Q{ 
      chown -R root:rvm /usr/local/rvm
      chmod -R g+w /usr/local/rvm
    }
  end
end

