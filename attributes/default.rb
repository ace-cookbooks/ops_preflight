node[:preflight][:login_user] = case node[:platform]
                                when 'ubuntu'
                                  username = 'ubuntu'
                                when 'amazon'
                                  username = 'ec2-user'
                                end
