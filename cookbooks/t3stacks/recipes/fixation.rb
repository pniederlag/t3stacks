#
# Cookbook Name:: t3stacks
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
require 'chef_metal'

# fixation on *review*
# allow any login on review and create user admin
if node['t3stacks']['enabled'].include? 'review' and node['t3stacks']['machines']['review'] and node['t3stacks']['machines']['review']['fixation'] 
  machine_execute "fix stuff on review" do
    # crontab -l | sed 's/ebian/xxxx/p' | crontab -
    command <<EOM
sed -i -e 's/exit(1)/exit(0)/' /var/gerrit/scripts/typo3org-authentication.php
curl -k "https://admin:egal@#{node['t3stacks']['machines']['review']['hostname']}/login/"
EOM
    machine "review"
  end
end
