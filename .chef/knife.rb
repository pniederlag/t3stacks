current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "metal-t3stack"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            [::File.join(current_dir, '..', 'cookbooks'), ::File.join(current_dir, '..', 'vendor/cookbooks')]
verify_api_cert          true
