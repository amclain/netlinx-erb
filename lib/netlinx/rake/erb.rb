
require 'yard'
require 'netlinx/rake/compile'
require 'netlinx/rake/src'

require_relative 'erb/generate_erb'
require_relative 'erb/generate_rpc'
require_relative 'erb/lines'


task :default=>[:generate_rpc, :doc, :compile, :pack]

NetLinx::Rake::ERB::Lines.new
NetLinx::Rake::ERB::GenerateERB.new
NetLinx::Rake::ERB::GenerateRPC.new :generate_rpc => :generate_erb

# Generate Ruby documentation.
YARD::Rake::YardocTask.new :doc do |t|
  puts "\n\n"
  # t.options = %w(- README.md)
end
