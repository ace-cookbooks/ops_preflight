action :install do
  ops_preflight_app_environment do
    app_name new_resource.app_name
    release_path new_resource.release_path
    rails_env new_resource.rails_env
  end

  ops_preflight_assets do
    app_name new_resource.app_name
    release_path new_resource.release_path
    rails_env new_resource.rails_env
  end

  new_resource.updated_by_last_action(true)
end
