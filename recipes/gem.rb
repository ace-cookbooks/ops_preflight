gem_package 'ops_preflight' do
  version node[:preflight][:gem_version]
  gem_binary '/usr/local/bin/gem'
  action :install
end
