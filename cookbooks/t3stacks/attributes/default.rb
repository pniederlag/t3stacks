# Load t3stacks attributes from the config file
default['t3stacks']['t3stacks_dir'] = ENV['T3STACKS_DIR']

# T3STACKS_DIR is set by the Rakefile to the project root directory
default['t3stacks']['repo_path'] = ENV['T3STACKS_DIR']
default['t3stacks']['vms_dir'] = File.join(ENV['T3STACKS_DIR'], 'vagrant_vms')

# host_cache_path is mapped to /tmp/cache on the VMs
#default['t3stacks']['host_cache_path'] = ENV['CACHE_PATH'] || File.join(ENV['T3STACKS_DIR'], 'cache')
#default['t3stacks']['vm_mountpoint'] = '/tmp/cache'

# SSH key distribution for inter-machine trust
#default['t3stacks']['root_ssh']['privkey'] = File.read(File.join(ENV['T3STACKS_DIR'], 'keys', 'id_rsa'))
#default['t3stacks']['root_ssh']['pubkey'] = File.read(File.join(ENV['T3STACKS_DIR'], 'keys', 'id_rsa.pub'))
