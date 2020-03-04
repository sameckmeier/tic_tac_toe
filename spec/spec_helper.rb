require "bundler/setup"
require "tic_tac_toe"
require "factory_bot"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.before(:suite) do
    FactoryBot.factories.clear
    FactoryBot.find_definitions
  end
end
