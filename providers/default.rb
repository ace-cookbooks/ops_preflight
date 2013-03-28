action :install do
  ops_preflight_app_environment new_resource.app_name do
    release_path new_resource.release_path
    rails_env new_resource.rails_env
  end

  ops_preflight_assets new_resource.app_name do
    release_path new_resource.release_path
    rails_env new_resource.rails_env
  end

  new_resource.updated_by_last_action(true)
end
