actions :install
default_action :install

attribute :app_name, :kind_of => String, :name_attribute => true
attribute :release_path, :kind_of => String
attribute :rails_env, :kind_of => String
