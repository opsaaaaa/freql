# frozen_string_literal: true

require "freql"
require "pry"

RSpec.configure do |config|
  MILLION = 1000000
  BILLION = 1000000000

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
