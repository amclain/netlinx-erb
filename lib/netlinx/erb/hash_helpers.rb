# ----------------
#   Hash Helpers
# ----------------

# A collection of helper methods for use in Hash
module HashHelpers
  
  # Template suffix (capitalized / unmodified).
  def tmpl_suffix
    Hash.instance_variable_get :@tmpl_suffix
  end
  
  # Template suffix for variables (lowercase).
  def tmpl_var_suffix
    Hash.instance_variable_get :@tmpl_var_suffix
  end
  
  # Append the @tmpl_suffix to each key in the hash.
  def append_suffix
    hash = self.map do |k,v|
      key_name = "#{k}"
      key_name += "_#{tmpl_suffix}" if tmpl_suffix and not tmpl_suffix.empty?
      
      [key_name.to_sym, v]
    end
    
    Hash[hash]
  end
  
  # Append the @tmpl_suffix to each key in the hash and overwrite this
  # hash with the result.
  def append_suffix!
    hash = append_suffix
    self.clear
    self.merge! hash
  end
  
end

Hash.class_eval { include HashHelpers }
