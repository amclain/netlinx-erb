
require 'rake'
require 'rake/tasklib'

module NetLinx
  module Rake
    module ERB
      
      # Generate NetLinx RPC file.
      class GenerateRPC < ::Rake::TaskLib
        
        attr_accessor :name
        
        def initialize name = :generate_rpc
          @name = name
          yield self if block_given?
          
          desc "Generate NetLinx RPC file."
          
          task(name) do
            require 'netlinx-erb'
            puts "\n\nGenerating RPC functions..."
            RPC.build
            puts "Done."
          end
        end
        
      end
    end
  end
end
