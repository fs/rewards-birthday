lib_dir = File.expand_path("lib", File.dirname(__FILE__))
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require "dotenv/load"
require "snitcher"
require "rewards-birthday"

namespace :rewards do
  desc "This task gives bonuses when someone has a birthday"
  task :give_birthday_bonus do
    RewardsBirthday.create_birthday_bonuses
    Snitcher.snitch(ENV["SNITCH_DAILY"]) if ENV["SNITCH_DAILY"]
  end
end
