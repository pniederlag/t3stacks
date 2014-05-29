require 'cheffish'
require 'chef_metal_vagrant'

repo_path = node['t3stacks']['repo_path']
vms_dir = node['t3stacks']['vms_dir']

directory vms_dir
vagrant_cluster vms_dir

directory repo_path
with_chef_local_server :chef_repo_path => repo_path,
  :cookbook_path => [ File.join(repo_path, 'cookbooks'),
    File.join(repo_path, 'vendor', 'cookbooks') ]

vagrant_box node['t3stacks']['vagrant']['box'] do
  url node['t3stacks']['vagrant']['box_url']
end

# set provisioner options for all of our machines
node['t3stacks']['vm_config']['backends'].merge(
  node['t3stacks']['vm_config']['frontends']).each do |vmname, config|

  local_provisioner_options = {
    'vagrant_config' => VagrantConfigHelper.generate_vagrant_config(vmname, config, node)
  }

  node.set['t3stacks']['provisioner_options'][vmname] = ChefMetal.enclosing_provisioner_options.merge(local_provisioner_options)

end
