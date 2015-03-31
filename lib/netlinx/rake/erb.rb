
require 'yard'
require 'netlinx/rake/compile'
require 'netlinx/rake/workspace/create_workspace_config'
require 'netlinx/rake/workspace/generate_apw'
require 'netlinx/rake/src'

require_relative 'erb/generate_erb'
require_relative 'erb/generate_rpc'
require_relative 'erb/lines'
require_relative 'erb/push'


task :default=>[:generate_rpc, :check_for_docs, :compile, :pack]

NetLinx::Rake::ERB::Lines.new
NetLinx::Rake::ERB::GenerateERB.new
NetLinx::Rake::ERB::GenerateRPC.new :generate_rpc => :generate_apw
NetLinx::Rake::ERB::Push.new

NetLinx::Rake::Workspace::CreateWorkspaceConfig.new
NetLinx::Rake::Workspace::GenerateAPW.new :generate_apw => :generate_erb

# Generate Ruby documentation.
YARD::Rake::YardocTask.new :doc do |t|
  puts "\n"
  # t.options = %w(- README.md)
end

# Make sure the readme has been converted to HTML.
task :check_for_docs do
  Rake::Task[:doc].invoke unless Dir.exists? 'doc'
end
