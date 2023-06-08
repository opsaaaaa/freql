# frozen_string_literal: true

require "freql"
require "pry"
require 'fileutils'

RSpec.configure do |config|
  MILLION = 1000000
  BILLION = 1000000000

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.before(:suite) do
    FileUtils.mkdir_p 'tmp/spec'
    FileUtils.rm_r Dir.glob('tmp/spec/*')
  end

  config.after(:each) do 
    FileUtils.rm_r Dir.glob('tmp/spec/*')
  end
  
  config.after(:suite) do 
    FileUtils.rm_r Dir.glob('tmp/spec')
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
