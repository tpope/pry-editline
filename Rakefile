require "bundler/gem_tasks"
task :default => :build

include_path = "-I#{File.expand_path('../lib', __FILE__)}"

task :pry do
  exec 'pry', include_path, '-rpry-editline'
end

task :irb do
  exec 'irb', include_path, '-rpry-editline'
end
