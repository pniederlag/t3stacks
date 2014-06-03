#
# Cookbook Name:: metaltest
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
require 'chef_metal'

#def chef_repo_path
#   "/srv/fileserver/projekte/t3-team-server/chef/"
#end

provider = node['t3stacks']['provider']
include_recipe("t3stacks::#{provider}")

# Set up a vagrant cluster (place for vms) in ~/machinetest
#puts config

chef_node "forge" do
    chef_environment "pre-production"
    # dev_mode is for chef-vault plain text databags
    attribute 'dev_mode', true
    action :create
end

chef_environment "pre-production" do
    action :create
end

machine 'forge' do
    action [:converge]
    chef_environment = "pre-production"
    # @todo find a better place for vagrant specific config (use config/attributes)
    add_machine_options :vagrant_options => {
      'vm.hostname' => 'forge.typo3.vagrant',
      }, :vagrant_config => <<-EOM
      config.vm.network "private_network", ip: "33.33.10.5"
      config.vm.provider 'virtualbox' do |v|
          v.customize [
            'modifyvm', :id,
            '--name', "forge.typo3.org"
          ]
      end
    EOM
    attribute 'site-forgetypo3org', {ssl_certificate: 'wildcard.vagrant', sso_enabled: false}
    attribute 'redmine', {hostname: 'forge.typo3.vagrant', database: {password: 'xxuendxuiendunie'}}
    #role 'debian'
    recipe 'site-forgetypo3org'
end

#machine 'mq' do
#    action [:converge]
#end

#machine 'review' do
#    action [:converge]
#end

#machine 'git' do
#    action [:converge]
#end
