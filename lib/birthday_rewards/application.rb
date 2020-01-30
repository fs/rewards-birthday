require "date"

require "rewards"

require "birthday_rewards/birthday_celebrants"
require "birthday_rewards/congratulation_factory"
require "birthday_rewards/congratulation"
require "birthday_rewards/rewards_api"

module BirthdayRewards
  class Application
    def self.token
      Rewards::Client.new.bot_create_token(
        ENV.fetch("REWARDS_BOT_NAME"),
        ENV.fetch("REWARDS_BOT_PASSWORD")
      )["data"]["attributes"]["token"]
    end

    def self.congratulate_birthday_celebrants
      Rewards::Client.base_uri(ENV.fetch("REWARDS_BASE_URI"))
      BirthdayRewards.new(
        RewardsAPI.new(
          Rewards::Client.new(token: token)
        ),
        CongratulationFactory.new(
          ENV.fetch("REWARDS_BIRTHDAY_TEMPLATE")
        ),
        BirthdayCelebrantsRule.new(date: Date.today)
      ).run
    end

    def initialize(rewards_api, congratulation_factory, celebrants_rule)
      @rewards_api = rewards_api
      @congratulation_factory = congratulation_factory
      @celebrants_rule = celebrants_rule
    end

    def run
      people = @rewards_api.people_with_birthdates
      celebrants = @celebrants_rule.apply(people)
      celebrants.each do |person|
        congratulation = @congratulation_factory.congratulation(person)
        @rewards_api.create_bonus(congratulation.to_s)
      end
    end
  end
end
