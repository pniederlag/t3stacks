#
# Cookbook Name:: metaltest
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
require 'chef_metal'
require 'chef_metal_vagrant'

#def chef_repo_path
#   "/srv/fileserver/projekte/t3-team-server/chef/"
#end

# Set up a vagrant cluster (place for vms) in ~/machinetest
vagrant_cluster "#{ENV['HOME']}/t3s-metaltest"

# set vagrant box
vagrant_box 'debian-7-amd64' do
    url 'http://boxes.datenbetrieb.de/debian-7-amd64.box'
    #  machine_options 'vagrant_config' => <<EOM
    #     config.vm.synced_folder (ENV['SRC_DIR'] || "#{ENV['HOME']}/oc/code/opscode"), "/mnt/host_src"
    #  #EOM
end

chef_node "forge" do
    chef_environment "pre-production"
    action :create
end

#chef_environment "pre-production" do
#    action :create
#end

machine 'forge' do
    action [:converge]
    chef_environment = "pre-production"
    attribute "xxxx", "tada"
    role 'debian'
    role 'site-forgetypo3org'
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
