# encoding: utf-8

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

desc 'Default: run unit test'
task :default => :unit_test

desc 'Run all tests' 
task :test => [:unit_test, :integration_test]

desc 'Run unit tests'
Rake::TestTask.new(:unit_test) do |t|
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end

desc 'Run integration tests (require to set proxy in test_helper.rb if needed)'
Rake::TestTask.new(:integration_test) do |t|
  t.libs << 'test'
  t.pattern = 'test/integration/*_test.rb'
  t.verbose = true
end