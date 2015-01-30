
require_relative 'helpers'

module NetLinx
  module ERB
    
    # @return a binding for ERB to evaluate code in.
    # @example
    #   ERB.new(buffer, nil, '%<>-').result(NetLinx::ERB.binding)
    def self.binding
      @b ||= Module.new.instance_eval {
        extend NetLinx::ERB::Helpers
        # TODO: _config.rb instance variables should be injected here.
        binding
      }
    end
    
  end
end
