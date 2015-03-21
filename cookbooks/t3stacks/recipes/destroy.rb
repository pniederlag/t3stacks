#
# Cookbook Name:: metaltest
# Recipe:: default
#
# Copyright (C) 2014
#
#
require 'chef/provisioning'

machine ENV['DESTROY_MACHINE'] do
  action :destroy
  #machines search(:node, '*:*').map { |n| n.name }
end