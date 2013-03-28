# NOTE: This does not currently support default instance ssh keys.
# You should really be using IAM users anyway.


directory "/home/#{node[:preflight][:login_user]}/.ssh" do
  owner node[:preflight][:login_user]
  group 'opsworks'
  mode 0700
end

keys = []

if node[:preflight][:users] && !node[:preflight][:users].empty?
  node[:preflight][:users].each do |name|
    ssh_user = node[:ssh_users].values.find { |user| user[:name] == name }

    if ssh_user.nil?
      Chef::Log.error("preflight user #{name} cannot be found in ssh users")
      next
    end

    keys << ssh_user[:public_key]
  end

  template "/home/#{node[:preflight][:login_user]}/.ssh/authorized_keys" do
    cookbook 'ops_preflight'
    source 'authorized_keys.erb'
    owner node[:preflight][:login_user]
    group 'opsworks'
    variables ({
      :public_keys => keys
    })
    only_if do
      File.exists?("/home/#{node[:preflight][:login_user]}/.ssh")
    end
  end
else
  Chef::Log.warn "Preflight setup requested but no preflight users specified."
end
