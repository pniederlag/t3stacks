require 'json'
require 'fileutils'
Dir["lib/tasks/*.rake"].each { |t| load t }

task :default => [:provision]

# Environment variables to be consumed by ec-t3stacks and friends
t3stacks_dir = ENV['T3STACKS_DIR'] = File.dirname(__FILE__)

def get_config
  JSON.parse(File.read('config.json'))
end

# default task, first init and then provision with chef-client
desc '[DEFAULT] startup virtual machines and provision them (includes init)'
task :provision => [:init] do
  system("#{t3stacks_dir}/bin/chef-client -z -o t3stacks::default,t3stacks::fixation")
end

# init task, setup keys, create cache dir, handle bundle and berks
desc 'basic setup and system check'
task :init => [:keygen, :cachedir, :config_copy, :bundle, :berks_install] do
  create_users_directory
end

task :start => :up

desc 'Destroy a machine'
task :destroy, [:machine] do |t,arg|
  system({"DESTROY_MACHINE" => arg.machine}, "#{t3stacks_dir}/bin/chef-client -z -o t3stacks::destroy")
  #Rake::Task['remove_hosts'].execute
end

# Vagrant standard but useful commands
%w(status halt suspend resume ssh).each do |command|
  desc "Equivalent to running: vagrant #{command} $machine"
  task :"#{command}", [:machine] do |t,arg|
    Dir.chdir(File.join(t3stacks_dir, 'vagrant_vms')) {
      system("vagrant #{command} #{arg.machine}")
    }
  end
end

desc 'update cookbooks by deleting vendor/cookbooks and Berksfile.lock'
task :update_cb do
  cookbooks_path = File.join(t3stacks_dir, 'vendor/cookbooks')
  system("rm -rf #{cookbooks_path} Berksfile.lock")
  system("#{t3stacks_dir}/bin/berks vendor #{cookbooks_path} --except private")
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

task :cachedir do
  if ENV['CACHE_PATH'] && Dir.exists?(ENV['CACHE_PATH'])
    cachedir = ENV['CACHE_PATH']
  else
    cachedir = File.join(t3stacks_dir, 'cache')
    Dir.mkdir cachedir unless Dir.exists?(cachedir)
  end
  puts "Using package cache directory #{cachedir}"
end

#desc 'Install required Gems into the vendor/bundle directory'
task :bundle do
  system('bundle install --path vendor/bundle --binstubs')
end

task :berks_install do
  cookbooks_path = File.join(t3stacks_dir, 'vendor/cookbooks')
  system("#{t3stacks_dir}/bin/berks vendor #{cookbooks_path}")
end