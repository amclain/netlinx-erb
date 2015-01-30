
require 'rake'
require 'rake/tasklib'

module NetLinx
  module Rake
    module ERB
      
      # Show lines of code for .axi files.
      class Lines < ::Rake::TaskLib
        
        attr_accessor :name
        
        def initialize name = :lines
          @name = name
          yield self if block_given?
          
          desc "Show lines of code for .axi files."
          
          task(name) do
            require 'netlinx/workspace'
            
            workspace_path = Dir['*.apw'].first
            workspace = NetLinx::Workspace.new file: workspace_path
            file_paths = workspace.projects.first.systems.first.files
              .map(&:path)
              .select { |path| File.extname(path) == '.axs' or File.extname(path) == '.axi' }
            
            puts "\n\nLines of code..."
              puts "----------------"
            
            lines_by_path = file_paths.map { |path| {path: path, lines: File.read(path).lines.count} }
            lines_by_path.each do |line_by_path|
              puts "#{line_by_path[:lines]}\t#{line_by_path[:path]}"
            end
            
            puts "-----\t--------------------"
            total = 0
            lines_by_path.map { |l| l[:lines] }.each { |lines| total += lines }
            puts "#{total}\tTotal"
          end
        end
        
      end
    end
  end
end
