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

machine ENV['DESTROY_MACHINE'] do
  action :destroy
  #machines search(:node, '*:*').map { |n| n.name }
end