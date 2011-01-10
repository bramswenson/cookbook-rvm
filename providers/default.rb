action :install do

  # install rvm system wide
  bash "install RVM" do
    user   "root"
    code   %{ bash < <( curl -L http://bit.ly/rvm-install-system-wide ) }
    not_if %{ test -f /usr/local/bin/rvm }
  end

end
