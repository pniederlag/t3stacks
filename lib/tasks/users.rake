# ensure users path exists
def create_users_directory
  FileUtils.mkdir_p(File.join(ENV['T3STACKS_DIR'], 'users'))
end
