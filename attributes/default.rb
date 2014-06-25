default[:preflight][:login_user] = case node[:platform]
                                when 'ubuntu'
                                  'ubuntu'
                                when 'amazon'
                                  'ec2-user'
                                end

default[:preflight][:gem_version] = '1.1.0'
