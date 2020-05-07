require "timecop"
require "byebug"
require "dotenv"

Dotenv.load(".env.test")

require "rewards-birthday"

module Helpers
  def fixture(name)
    JSON.parse(File.read("spec/fixtures/#{name}.json"))
  end

  def fixture_by_id(name, id)
    fixture(name).find { |hash| hash["id"].to_i == id }
  end
end

RSpec.configure do |config|
  config.include(Helpers)

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
