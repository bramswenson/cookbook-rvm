action :install do
  # rvm_gem supports Array for name and ruby attributes
  # so you can install multiple gems into multiple gemsets with one block
  # rvm_gem [ 'rake', 'bundler' ] do
  #   ruby [ '1.9.2@rails', '1.8.7@potsdam' ]
  # end
  # installs rake and bundler (latest versions) into both gemsets
  rubies = new_resource.ruby.kind_of?(Array) ? new_resource.ruby : [ new_resource.ruby ]
  gems   = new_resource.name.kind_of?(Array) ? new_resource.name : [ new_resource.name ]
  rubies.each do |ruby|
    # create the gemset and ruby
    rvm_gemset ruby do
      action :create
    end
    gems.each do |gem|
      # install the gem package using the proper gemset via gem_binary attr
      gem_package gem do
        action       :install
        gem_binary   "rvm #{ruby} gem"
        source new_resource.source  if new_resource.source
        version new_resource.version if new_resource.version
      end
    end
  end
  # update the rvm perms after gem installs
  # TODO: make this less suck, like only update when perms are wrong
  bash "update rvm perms" do
    code %Q{ 
      chown -R root:rvm /usr/local/rvm
      chmod -R g+w /usr/local/rvm
    }
  end
end

