action :install do
  app_name = new_resource.app_name
  release_path = new_resource.release_path
  rails_env = new_resource.rails_env

  Chef::Log.info('Installing ops_preflight assets')
  Chef::Log.debug("app_name = #{app_name}") rescue nil
  Chef::Log.debug("release_path = #{release_path}") rescue nil
  Chef::Log.debug("rails_env = #{rails_env}") rescue nil

  execute "ops_preflight download bundle" do
    command "/usr/local/bin/preflight-server download -b #{node[:preflight][:bucket]} -f #{release_path}/tmp/preflight-#{app_name}-bundle-#{rails_env}.tgz"
    cwd release_path
    user "deploy"
    group "opsworks"
  end

  execute "ops_preflight extract bundle" do
    command "tar -zxvf #{release_path}/tmp/preflight-#{app_name}-bundle-#{rails_env}.tgz -C #{node[:deploy][app_name][:home]}/.bundler/#{app_name} --strip-components=1 > /dev/null"
    cwd release_path
    user "deploy"
    group "opsworks"
  end

  execute "ops_preflight download assets" do
    command "/usr/local/bin/preflight-server download -b #{node[:preflight][:bucket]} -f #{release_path}/tmp/preflight-#{app_name}-assets-#{rails_env}.tgz"
    cwd release_path
    user "deploy"
    group "opsworks"
  end

  execute "ops_preflight extract assets" do
    command "tar -zxvf #{release_path}/tmp/preflight-#{app_name}-assets-#{rails_env}.tgz -C #{release_path}/public > /dev/null"
    cwd release_path
    user "deploy"
    group "opsworks"
  end

  new_resource.updated_by_last_action(true)
end
