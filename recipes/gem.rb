gem_package 'ops_preflight' do
  version node[:preflight][:gem_version]
  action :nothing
end.run_action(:install)
Gem.clear_paths
