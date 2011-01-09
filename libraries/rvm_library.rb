module RvmLibrary
  def ruby_package_dependencies(ruby)
    pkgs = []
    if ruby =~ /^1\.[89]\../ || ruby =~ /^ree/ || ruby =~ /^ruby-/
      case node[:platform]
        when "centos","redhat","fedora","suse"
          pkgs = %w{ gcc-c++ patch readline readline-devel zlib zlib-devel 
                     libyaml-devel libffi-devel openssl-devel } #iconv-devel }
          # TODO: Figure out the real state of iconv-devel and fixup the next few lines
          # NOTE: For centos 5.4 final iconv-devel might not be available :(
          #pkgs.delete('iconv-devel') if (node[:platform] == "centos" && 
          #                                !node[:platform_version] == '5.5')
          pkgs << %w{git subversion autoconf} if ruby =~ /^ruby-head$/
        when "debian","ubuntu"
          pkgs = %w{ build-essential bison openssl libreadline6 libreadline6-dev
                     zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 
                     libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev ssl-cert }
          pkgs << %w{ git-core subversion autoconf } if ruby =~ /^ruby-head$/
      end
    elsif ruby =~ /^jruby/
      include_recipe "java"
    end 
    return pkgs
  end
end
