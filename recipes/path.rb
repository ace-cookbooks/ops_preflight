if node[:preflight][:path]
  directory node[:preflight][:path] do
    owner node[:preflight][:login_user]
    group "opsworks"
    mode 00644
    action :create
  end

  link "/home/#{node[:preflight][:login_user]}/preflight" do
    to node[:preflight][:path]
  end
end
