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
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec'
require 'rspec/core/rake_task'
desc "Run all examples"
task RSpec::Core::RakeTask.new('spec')

task :default => :spec
