
require 'rake'
require 'rake/tasklib'

module NetLinx
  module Rake
    module ERB
      
      # Generate Netlinx source code files from the erb template files.
      class GenerateERB < ::Rake::TaskLib
        
        attr_accessor :name
        
        def initialize name = :generate_erb
          @name = name
          yield self if block_given?
          
          desc "Generate Netlinx source code files from the erb template files."
          
          task(name) do
            require 'netlinx-erb'
            
            puts "Generating NetLinx files from ERB..."
            puts "------------------------------------"
            
            templates = Dir['include/**/*.erb']
            
            templates.each do |template|
              file_name = template.gsub /\.erb$/, ''
              puts "   #{file_name}"
              
              $AUTOGEN_HEADER = <<-HEADER
(***********************************************************)
(*                         WARNING                         *)
(***********************************************************}
    This file was generated from the following template
    and should NOT be edited directly: 
    
      #{template}
    
    See the documentation at `doc/index.html` for
    information about maintaining this project.
    
    Generated with netlinx-erb:
      https://github.com/amclain/netlinx-erb
{***********************************************************)

          HEADER
              
              File.open file_name, 'w+' do |file|
                  file.write NetLinx::ERB.execute(template)
              end
            end
            
            puts "\nDone."
          end
        end
        
      end
    end
  end
end
