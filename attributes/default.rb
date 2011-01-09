default[:rvm][:default_ruby] = '1.9.2@global'
default[:rvm][:global_gems]  = %w{ rake bundler }
default[:rvm][:users] = [ 'root' ]
default[:rvm][:rvmrc] = { 
  'rvm_install_on_use_flag' => 1,
  'rvm_gemset_create_on_use_flag' => 1,
}
