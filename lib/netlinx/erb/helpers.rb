
require_relative 'hash_helpers'

module NetLinx
  module ERB
    
    # A collection of code generation helper methods for use in NetLinx ERB files.
    module Helpers
      
      
      # @group Formatting
      
      
      # Generate a group of lines for a given hash.
      # @param hash [Hash]
      # @param padding [String, Numeric] whitespace placed in front of the string.
      #   Can be a string of spaces, or a number representing the indentation level.
      # @yield [key, value] elements from hash
      # @return [String] lines of source code
      def group hash, padding: nil, &block
        padding = ' ' * (4 * padding) if padding.is_a?(Numeric)
        hash.map { |key, value| block.call key, value }.compact.map { |str| padding.to_s + str }.join("\n")
      end

      # Left justify a block of code to line up on a type of character.
      # Defaults to :equals (=).
      #
      # @param amount [Numeric] value of number of spaces, or the longest key in a hash.
      # @param type [:equals, :colon, :comma, :comma_2, :semicolon] character to justify on.
      # @return [String] a group of justified lines of source code.
      def justify str, amount: nil, type: nil
        # justification_amount = amount.is_a?(Numeric) ? amount : amount.map { |key, _| key.to_s.size }.max
        
        lines = str.split "\n"
        
        justify_types = {
          equals:    lines.map { |line| line.index "=" }.compact.max,
          colon:     lines.map { |line| line.index ":" }.compact.max,
          comma:     lines.map { |line| line.index "," }.compact.max,
          comma_2:   lines.map { |line| line.index "," }.compact.max,
          semicolon: lines.map { |line| line.index ";" }.compact.max,
        }
        
        # Types that will be chosen from automatically if no type is specified
        auto_justify_types = [:equals, :colon]
        
        justify_by = justify_types.select { |k,v|
          auto_justify_types.include?(k) && !v.nil?
        }.min
        justify_by = justify_by.first if justify_by
        justify_by = type if type
        
        justify_amount = amount || justify_types[justify_by] || 0
        
        # Rebuild each line with the appropriate justification.
        lines.map! { |line|
          output = ''
          
          case justify_by
          when :equals
            line =~ /(.*?)(=.*)/
            output = $2.nil? ? line : $1.ljust(justify_amount) + $2
          when :colon
            line =~ /(.*?\:)\s*(.*)/
            output = $2.nil? ? line : $1.ljust(justify_amount + 1) + '    ' + $2
          when :comma
            line =~ /(.*?\,)\s*(.*)/
            output = $2.nil? ? line : $1.ljust(justify_amount + 1) + ' ' + $2
          when :comma_2
            line =~ /(.*?\,.*?\,)\s*(.*)/
            output = $2.nil? ? line : $1.ljust(justify_amount + 1) + ' ' + $2
          when :semicolon
            line =~ /(.*?\;)\s*(.*)/
            output = $2.nil? ? line : $1.ljust(justify_amount + 1) + '  ' + $2
          else
            line
          end
        }.join "\n"
      end
      
      
      # @group Code Generation
      
      
      # Print the list of devices.
      # @param h [Hash] device names as keys.
      # @param justify [Numeric] column number to justify equals symbol (=) on.
      # @return [String] a group of justified lines of source code.
      def print_device_hash h, justify: nil
        # TODO: Refactor to use #justify.
        max_len = h.map { |name, value| name.size }.max
        h.map { |name, value| "dv#{name.to_s.upcase.ljust justify || max_len} = #{value};" }.join("\n")
      end

      # Print the list of constants.
      # @param h [Hash] constant names as keys.
      # @param justify [Numeric] column number to justify equals symbol (=) on.
      # @return [String] a group of justified lines of source code.
      def print_constant_hash h, justify: nil
        # TODO: Refactor to use #justify.
        max_len = h.map { |name, value| name.size }.max
        h.map { |name, value| "#{name.to_s.upcase.ljust justify || max_len} = #{value};" }.join("\n")
      end
      
      # Print the list of variables.
      # Format:
      #   {
      #     var_name: { type: :integer, default: 0, comment: 'my var' }
      #   }
      # @param h [Hash] variable names as keys.
      # @return [String] a group of justified lines of source code.
      def print_variable_hash h
        justify group(h) { |name, params|
          type     = params.fetch :type,     :integer
          default  = params.fetch :default,  nil
          comment = params.fetch :comment, nil
          
          output = "#{type} #{name.to_s.downcase}"
          output += " = #{default}" if default
          output += ";"
          output += "  // #{comment}" if comment
          output
        }
      end
      
      # Generate instance variables for the DEFINE_CONSTANTS section
      # from the given hash keys.
      # Appends @tmpl_suffix if set.
      # @see #print_variable_hash #print_variable_hash - for formatting
      def generate_constant_ivars h, append_suffix: false
        h.each_key do |key|
          value = key.to_s.upcase
          value = "#{value}_#{@tmpl_suffix.to_s.upcase}" if @tmpl_suffix and append_suffix
          
          instance_variable_set :"@#{key.to_sym}", value
        end
        
        h
      end
      
      # Generate instance variables for the DEFINE_VARIABLES section
      # from the given hash keys.
      # Appends @tmpl_var_suffix if set.
      # @see #print_variable_hash #print_variable_hash - for formatting
      def generate_variable_ivars h, append_suffix: true
        h.each_key do |key|
          value = key.to_s.downcase
          value = "#{value}_#{@tmpl_suffix.to_s.downcase}" if @tmpl_suffix and append_suffix
          
          instance_variable_set :"@#{key.to_sym}", value
        end
        
        h
      end
      
      # Automatically comment out the input unless the condition is met.
      # @param str [String] NetLinx source code string
      # @param condition comments out the source code string if evaluates to false or nil
      # @return [String] NetLinx source code
      def auto_comment str, condition
        condition ? str : str.split("\n").map { |line| "// " + line }.join("\n")
      end

      # Generate button events for the given hash of buttons.
      # @param buttons [Hash] button constants
      # @param device [String] touch panel device constant.
      #   @dvTP comes from ERB template.
      # @return [String] \[dev, chan\] source code
      def button_event buttons, device = @dvTP
        buttons.map { |name, _| "button_event[#{device}, #{name}]" }.join("\n")
      end
      
      # Generate a button_event block for the given hash of buttons.
      # @param buttons [Hash] button constants
      # @param kwargs [Hash]
      # @option kwargs [String] :function name of the function to call in the switch block
      # @option kwargs [Symbol, nil] :remap name of symbol to use to {Hash#remap} the hash.
      #   This is a convenience arg for readability; the hash can also be remapped
      #   before passed into this method.
      # @option kwargs [String] :device touch panel device constant.
      #   @dvTP comes from ERB template.
      # @option kwargs [String, Numeric] :padding (3) whitespace placed in front of the string.
      #   Can be a string of spaces, or a number representing the indentation level.
      # @option kwargs [Boolean] :momentary (false) adds a `to` statement for momentary button feedback
      # @option kwargs [Boolean] :hold_block (false) create a hold block for the event
      # @option kwargs [Boolean] :hold_time (0.6) repeat time for the hold block
      # @yield [value, name] option to create a custom function call string.
      #   Modifies the function arguments if :function is set, otherwise modifies
      #   the entire function call string.
      # @yieldparam value value of the buttons hash for the given key. Accounts for remap.
      # @yieldparam name [Symbol] key of the buttons hash
      # @yieldreturn [String] function string
      # 
      # @example
      #   button_event_block bluray_key_constants.remap(:key),
      #     function: 'bluray_key', momentary: true
      #     
      #   button_event_block channel_strip_constants.select {|k,_| k.to_s.end_with? "_UP"},
      #     function: 'audio_increment_volume', remap: :audio, hold_block: true, momentary: true
      #     
      #   # Use block to create function string.
      #   # :function not set
      #   button_event_block(video_source_constants) { |h|
      #     "video_patch(#{h[:input]}, #{h[:dest]})"
      #   }
      #   
      #   # Use block to create parameters string.
      #   # :function is set
      #   button_event_block(video_source_constants, function: 'video_patch') { |h|
      #     "#{h[:input]}, #{h[:dest]}"
      #   }
      #   
      #   # Use block to specify an array of parameters.
      #   # :function is set
      #   button_event_block(video_source_constants, function: 'video_patch') { |h|
      #     [h[:input], h[:dest]]
      #   }
      #
      def button_event_block buttons, **kwargs, &block
        function   = kwargs.fetch :function, nil
        device     = kwargs.fetch :device, @dvTP
        remap      = kwargs.fetch :remap, nil
        padding    = kwargs.fetch :padding, 3
        momentary  = kwargs.fetch :momentary, false
        hold_block = kwargs.fetch :hold_block, false
        hold_time  = kwargs.fetch :hold_time, 0.6
        
        buttons = buttons.remap(remap) if remap
        
        case_string = justify group(buttons, padding: padding) { |name, value|
          str = if block_given?
            block_val = block.call value, name
            block_val = block_val.join ', ' if block_val.is_a? Array
          
            if function
              "#{function}(#{block_val})"
            else
              "#{block_val}"
            end
          else
            "#{function}(#{value})"
          end
          
          auto_comment "case #{name}: #{str};", value
        }
        
        momentary_string = momentary ? "\n        to[button.input];\n        " : ''
        
        output = <<EOS
#{button_event buttons, device}
{
    push:
    {#{momentary_string}
        switch (button.input.channel)
        {
#{          case_string }
        }
    }
    
EOS
        
        if hold_block
          hold_string = <<EOS
    hold[#{hold_time}, repeat]:
    {
        switch (button.input.channel)
        {
#{          case_string }
        }
    }
    
EOS
          output += hold_string
        end
        
        output +=
<<EOS
    release: {}
}
EOS
        output.chomp
      end
      
      # Generate an empty HiQnet address string.
      # 
      # @example
      #   # Generates:
      #   '0x000000000000'
      def hiqnet_empty
        '0x' + ('0' * 12)
      end
      
      # Send a touch panel command to show or hide a control.
      # @param control [Symbol, String] address or constant of a control
      # @param show [Boolean, Numeric, String] 0/1 print verbatim.
      #   true/fase convert to 0/1.
      #   string expression is wrapped in itoa().
      # 
      # @example
      #   ^SHO-<control>,<0|1>
      def show_control control, show, device: @dvTP
        str = "send_command #{device}, \"'^SHO-', itoa(#{control}), ',"
        
        if show.is_a? Fixnum
          str += "#{show}'"
        elsif show == true or show == false or show == nil
          str += "#{show ? 1 : 0}'"
        else
          str += "', itoa(#{show})"
        end
        
        str += "\";"
      end
      
      # Run ERB on the given template file.
      # @param template_file [String] file path
      # @return [String] ERB output.
      # @raise [LoadError] template not found
      def execute_erb template_file
        raise LoadError, "Template not found: #{template_file}" unless File.exists? template_file
        $AUTOGEN_HEADER + ::ERB.new(File.read(template_file), nil, '%<>-').result()
      end
      
      
      # @group Other
      
      
      # Ensures button number constants haven't been unintentionally duplicated.
      # @param hashes [*Hash]
      # @raise if two keys have the same value.
      def check_for_duplicate_values *hashes
        raise NotImplementedError
      end

    end
  end
end

# :nodoc:
class Hash
  
  # Reconstructs a single level hash out of a hash with nested parameters.
  # @param nested_key use the value associated with this key in the nested hash
  # @return [Hash] keys mapped to the set of values specified
  # 
  # @example
  #   buttons = {
  #     :TOUCH_PANEL_BUTTON_1 => { btn: 1, matrix_input: :MTX_IN_DVD },
  #     :TOUCH_PANEL_BUTTON_2 => { btn: 2, matrix_input: :MTX_IN_VCR }
  #   }
  # 
  #   # buttons.remap(:btn) will return a hash of touch panel button
  #   # symbols with the :btn numbers mapped as the values, and
  #   # :matrix_input will be discarded.
  def remap nested_key
    self.map { |k,v| [k, v[nested_key]] }.to_h
  end
  
end

# Patch Array#to_h into Ruby 2.0
unless RUBY_VERSION >= '2.1.0'
  # :nodoc:
  class Array
    # Convert array to hash.
    def to_h
      Hash[self]
    end
  end
end

# :nodoc:
class String
  
  # Intended for initializing struct constants.
  def remove_comma_after_last_item
    self.gsub(/(?<=\}),(.*?)\z/, ' \1')
  end
  
  # Convert a string to a HiQnet address struct.
  #   Can include state variable.
  # @param sv [String, Integer, nil], state variable
  # 
  # @example
  #   '0x100203000103'.to_hiqnet(0x0000)
  #   # Generates:
  #   {$10, $02, $03, $00, $01, $03, $00, $00},
  def to_hiqnet sv = nil
    sv ||= ''
    sv = sv.is_a?(Fixnum) ? sv.to_s(16) : sv.to_s
    sv = sv.rjust(4, '0') unless sv.empty?
      
    address = self + sv
    "{#{address.gsub(/\A0x/, '').upcase.scan(/../).map {|s| '$' + s}.join(', ')}},"
  end
  
end
