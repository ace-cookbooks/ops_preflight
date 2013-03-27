actions :install
default_action :install

attribute :app_name, :kind_of => String, :name_attribute => true
attribute :release_path, :kind_of => String
attribute :rails_env, :kind_of => String

# default_action :install
# Needs this until chef 0.10.10
def initialize(*args)
  super
  @action = :install
end
