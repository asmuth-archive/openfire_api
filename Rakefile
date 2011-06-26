require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "openfire_api"
  gem.homepage = "http://github.com/paulasmuth/openfire_api"
  gem.summary = %Q{ruby client for the openfire userservice api}
  gem.description = %Q{ruby client for the openfire xmpp-server user_service api}
  gem.email = "paul@23linesofcode.com"
  gem.authors = ["Paul Asmuth"]
  #gem.add_runtime_dependency 'jabber4r', '> 0.1'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec'
require 'rspec/core/rake_task'
desc "Run all examples"
task RSpec::Core::RakeTask.new('spec') 

#require 'rake/testtask'
#Rake::TestTask.new(:test) do |test|
#  test.libs << 'lib' << 'test'
#  test.pattern = 'test/**/test_*.rb'
#  test.verbose = true
#end

#require 'rdoc/task'
#Rake::RDocTask.new do |rdoc|
#  version = File.exist?('VERSION') ? File.read('VERSION') : ""
#  rdoc.rdoc_dir = 'rdoc'
#  rdoc.title = "openfire_api #{version}"
#  rdoc.rdoc_files.include('README*')
#  rdoc.rdoc_files.include('lib/**/*.rb')
#end
