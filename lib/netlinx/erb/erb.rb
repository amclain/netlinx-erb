
module NetLinx
  module ERB
    
    # @return a binding for ERB to evaluate code in.
    # @example
    #   ERB.new(buffer, nil, '%<>-').result(NetLinx::ERB.binding)
    def self.binding
      Module.new.instance_eval {
        extend NetLinx::ERB::Helpers
        binding
      }
    end
    
  end
end
