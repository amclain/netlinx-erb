
require 'rake'
require 'rake/tasklib'

module NetLinx
  module Rake
    module ERB
      
      # Push project to NetLinx master(s).
      class Push < ::Rake::TaskLib
        
        attr_accessor :name
        
        def initialize name = :push
          @name = name
          yield self if block_given?
          
          desc "Push project to NetLinx master(s)."
          
          task(name) do
            require 'netlinx-erb'
            
            puts "Pushing files to master(s)..."
            
            # AMX BUG:
            # Make sure FileTransfer isn't running when FTCon.exe is executed.
            # FileTransfer2.exe fails to terminate if it fails to connect to
            # a master controller. This causes the first workspace to remain
            # in memory, even if the workspace settings are changed and
            # FileTransfer2.exe is executed again. Sometimes it ignores the
            # kill signal, so the /f flag is used to force termination.
            # 
            # Reported to AMX support on 2015-03-30.
            # Escalation# 26107
            # If you encounter this bug, report it to AMX:
            # Support@amx.com or 1-800-932-6993
            if Gem.win_platform?
              IO.popen "taskkill /f /im FileTransfer2.exe 2> nul"
            else
              IO.popen "killall -q -s KILL FileTransfer2.exe"
            end
            
            sleep 0.25 # Let process terminate.
            
            # TODO: Implement ENV['NETLINX_ACTIVE_SYSTEM_ONLY']
            # TODO: Implement filtering by type:
            #   code, master files (code, IR), touch panels,
            #   specific touch panel/device
            
            Dir["*.apw"].first.tap do |apw_file|
              unless apw_file
                puts "NetLinx workspace file not found."
                exit
              end
              
              system "FTCon \"#{apw_file}\""
              puts "Done.\n\n"
            end
          end
        end
        
      end
    end
  end
end
