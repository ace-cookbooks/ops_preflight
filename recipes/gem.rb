gem_package 'ops_preflight' do
  version node[:preflight][:gem_version]
  gem_binary node[:dependencies][:gem_binary]
  action :nothing
end.run_action(:install)
Gem.clear_paths
