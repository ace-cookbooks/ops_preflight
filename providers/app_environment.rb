action :install do
  app_name = new_resource.app_name
  release_path = new_resource.release_path
  rails_env = new_resource.rails_env

  Chef::Log.info('Installing ops_preflight app environment')
  Chef::Log.debug("app_name = #{app_name}") rescue nil
  Chef::Log.debug("release_path = #{release_path}") rescue nil
  Chef::Log.debug("rails_env = #{rails_env}") rescue nil

  app_vars = node[:env_vars][app_name][rails_env] rescue {}

  if app_vars && !app_vars.empty?
    Chef::Log.debug("Installing env file for #{rails_env}")
    template "#{release_path}/.env.#{rails_env}" do
      cookbook "ops_preflight"
      source "env.erb"
      mode "0660"
      owner node[:deploy][app_name][:user]
      group node[:deploy][app_name][:group]
      variables(:env_vars => app_vars)
    end
  end

  new_resource.updated_by_last_action(true)
end
