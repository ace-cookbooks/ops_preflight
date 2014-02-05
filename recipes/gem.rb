gem_package 'ops_preflight' do
  version node[:preflight][:gem_version]
  gem_binary '/usr/bin/gem'
  action :install
end
