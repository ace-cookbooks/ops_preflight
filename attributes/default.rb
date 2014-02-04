node.default[:preflight][:login_user] = case node[:platform]
                                when 'ubuntu'
                                  'ubuntu'
                                when 'amazon'
                                  'ec2-user'
                                end
