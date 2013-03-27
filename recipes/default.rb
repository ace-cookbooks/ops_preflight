# NOTE: This does not currently support default instance ssh keys.
# You should really be using IAM users anyway.

username = nil
case node[:platform]
when 'ubuntu'
  username = 'ubuntu'
when 'amazon'
  username = 'ec2-user'
end

directory "/home/#{username}/.ssh" do
  owner username
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

  template "/home/#{username}/.ssh/authorized_keys" do
    cookbook 'opsworks_preflight'
    source 'authorized_keys.erb'
    owner username
    group 'opsworks'
    variables ({
      :public_keys => keys
    })
    only_if do
      File.exists?("/home/#{username}/.ssh")
    end
  end
else
  Chef::Log.warn "Preflight setup requested but no preflight users specified."
end
