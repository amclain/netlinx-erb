
require 'rspec/core/rake_task'
require 'yard'

task :default => :test

RSpec::Core::RakeTask.new :test do |c|
  c.rspec_opts = '--color --format Fivemat'
end

# Build the gem.
task :build => [:package_template, :doc] do
  Dir['*.gem'].each {|file| File.delete file}
  system 'gem build *.gemspec'
end

# Rebuild and [re]install the gem.
task :install => :build do
  system 'gem install *.gem'
end

# Generate documentation.
YARD::Rake::YardocTask.new :doc do |t|
  t.options = %w(- license.txt)
end

task :package_template do
  require 'zip'
  
  zip_file = 'template.zip'
  File.delete zip_file if File.exists? zip_file
  
  Zip::File.open zip_file, Zip::File::CREATE do |zip|
    Dir['template/**/*', 'template/**/.*'].each do |file|
      zip.add file.gsub(/^template\//, ''), file
    end
  end
end
