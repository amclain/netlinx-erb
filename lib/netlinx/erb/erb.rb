
require_relative 'helpers'

module NetLinx
  module ERB
    
    # @return a binding for ERB to evaluate code in.
    # @example
    #   ERB.new(buffer, nil, '%<>-').result(NetLinx::ERB.binding)
    def self.binding
      # Issue #2
      # https://github.com/amclain/netlinx-erb/issues/2
      # 
      # Although ||= seemed like a good idea to pass data from _config.axi.erb
      # to the templates, in reality it causes data to be retained between
      # all files thoughout the entire generation process. This was causing
      # _config.axi to be populated when it should have only contained the
      # generation header.
      # 
      # This method needs to be refactored in a way that the module can be
      # populated with general framework helpers, then captured by a project-
      # specific configuration (_config.axi.erb) to be injected with project
      # data, then have that module's binding passed back to
      # NetLinx::ERB::Helpers.execute_erb. There needs to be a default binding
      # for non-templated files.
      
      # @b ||= Module.new.instance_eval {
      @b = Module.new.instance_eval {
        extend NetLinx::ERB::Helpers
        # TODO: _config.rb instance variables should be injected here.
        binding
      }
    end
    
    # Run ERB on the given template file.
    # @param template_file [String] file path
    # @param binding [Binding]
    # @return [String] ERB output.
    # @raise [LoadError] template not found
    def self.execute template_file, binding: NetLinx::ERB.binding
      raise LoadError, "Template not found: #{template_file}" unless File.exists? template_file
      $AUTOGEN_HEADER + ::ERB.new(File.read(template_file), nil, '%<>-')
        .result(binding)
    end
    
  end
end
