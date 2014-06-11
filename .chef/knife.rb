current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "metal-t3stack"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            [::File.join(current_dir, '..', 'cookbooks'), ::File.join(current_dir, '..', 'vendor/cookbooks')]
data_bag_path            ::File.join(current_dir, '..', 'data_bags')
#verify_api_cert          true

config_dir "#{File.expand_path('..', __FILE__)}/" # Wherefore art config_dir, chef?
local_mode true
begin
      chef_zero.host '127.0.0.1'
rescue
end

# profiles for chef-metal
#profile 'xxxefault'
#profiles {
#    'default' => {
#    }
#}
