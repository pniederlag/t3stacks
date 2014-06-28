require 'json'
require 'fileutils'
Dir["lib/tasks/*.rake"].each { |t| load t }

task :default => [:up]

# Environment variables to be consumed by ec-t3stacks and friends
t3stacks_dir = ENV['T3STACKS_DIR'] = File.dirname(__FILE__)

def get_config
  JSON.parse(File.read('config.json'))
end

desc 'Install required Gems into the vendor/bundle directory'
task :bundle do
  system('bundle install --path vendor/bundle --binstubs')
end

desc 'Bring the VMs online and install+configure Enterprise Chef HA'
task :up => [:keygen, :cachedir, :config_copy, :bundle, :berks_install] do
  create_users_directory
  if system("#{t3stacks_dir}/bin/chef-client -z -o t3stacks::default,t3stacks::fixation")
    Rake::Task['add_hosts'].execute
  end
end

task :start => :up

desc 'Destroy a machine'
task :destroy, [:machine] do |t,arg|
  system({"DESTROY_MACHINE" => arg.machine}, "#{t3stacks_dir}/bin/chef-client -z -o t3stacks::destroy")
  #Rake::Task['remove_hosts'].execute
end

desc 'SSH to a machine like so: rake ssh[backend1]'
task :ssh, [:machine] do |t,arg|
  Dir.chdir(File.join(t3stacks_dir, 'vagrant_vms')) {
    system("vagrant ssh #{arg.machine}")
  }
end

# Vagrant standard but useful commands
%w(status halt suspend resume).each do |command|
  desc "Equivalent to running: vagrant #{command}"
  task :"#{command}" do
    Dir.chdir(File.join(t3stacks_dir, 'vagrant_vms')) {
      system("vagrant #{command}")
    }
  end
end

task :config_copy do
  config_file = File.join(t3stacks_dir, 'config.json')
  config_ex_file = File.join(t3stacks_dir, 'examples', 'config.json.example')
  unless File.exists?(config_file)
    FileUtils.cp(config_ex_file, config_file)
  end
end

task :keygen do
  keydir = File.join(t3stacks_dir, 'keys')
  Dir.mkdir keydir unless Dir.exists? keydir
  if Dir["#{keydir}/*"].empty?
    system("ssh-keygen -t rsa -P '' -q -f #{keydir}/id_rsa")
  end
end

desc 'Add hosts entries to /etc/hosts'
task :add_hosts do
  config = get_config
  puts "@todo: hosts/dns management"
  #create_hosts_entries(config['machines'])
  #print_final_message(config, t3stacks_dir)
end

desc 'Remove hosts entries to /etc/hosts'
task :remove_hosts do
  config = get_config
  puts "@todo: hosts/dns management"
  #remove_hosts_entries(config['machines'])
end

task :cachedir do
  if ENV['CACHE_PATH'] && Dir.exists?(ENV['CACHE_PATH'])
    cachedir = ENV['CACHE_PATH']
  else
    cachedir = File.join(t3stacks_dir, 'cache')
    Dir.mkdir cachedir unless Dir.exists?(cachedir)
  end
  puts "Using package cache directory #{cachedir}"
end

task :berks_install do
  cookbooks_path = File.join(t3stacks_dir, 'vendor/cookbooks')
  system("#{t3stacks_dir}/bin/berks vendor #{cookbooks_path}")
end
