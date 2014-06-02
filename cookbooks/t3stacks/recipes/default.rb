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
    attribute 'site-forgetypo3org', {ssl_certificate: 'wildcard.vagrant'}
    #attribute "xxxx", "tada"
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
