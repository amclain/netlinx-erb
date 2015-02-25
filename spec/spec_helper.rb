
require 'pry'
require 'rspec/its'
require 'coveralls'

require 'netlinx-erb'

Coveralls.wear!

Thread.abort_on_exception = true

RSpec.configure do |c|
  # Enable 'should' syntax
  c.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
  c.mock_with(:rspec)   { |c| c.syntax = [:should, :expect] }
  
  # Only run tests marked with focus:true.
  # Enables use of fdescribe, fit, fspecify.
  c.filter_run_including focus:true
  c.run_all_when_everything_filtered = true
  
  # Abort after first failure.
  # (Use environment variable for developer preference)
  c.fail_fast = true if ENV['RSPEC_FAIL_FAST']
  
  # Set output formatter and enable color.
  # c.formatter = 'Fivemat'
  # c.color     = true
end
