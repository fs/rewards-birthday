require "rewards-birthday/rollbar"
require "rewards-birthday/user_fetcher"
require "rewards-birthday/bonus"
require "rewards-birthday/templates"
require "rewards-birthday/templates/birthday"
require "rewards"

module RewardsBirthday
  class Base
    DEFAULT_BASE_URL = "http://rewards.team/api/v1".freeze

    attr_reader :emails

    def initialize(emails = nil)
      @emails = emails

      Rewards::Client.base_uri(base_uri)
    end

    def create_birthday_bonus
      users = load_users(token)
      birthdays = fetch_people("birthdays", users)
      return unless birthdays

      Bonus.new(
        token: token,
        template: RewardsBamboohr::Templates::Birthday
      ).create_bonuses(birthdays)
    end

    private
  
    def fetch_people(event, users)
      return UserFetcher.new(users).by_emails(emails) if emails.present?

      UserFetcher.new(users).public_send("today_#{event}")
    end

    def load_users(token)
      Rewards::Client.new(token: token)
        .bot_users["data"]
    end

    def token
      Rewards::Client.new.bot_create_token(
        ENV.fetch("REWARDS_BOT_NAME"),
        ENV.fetch("REWARDS_BOT_PASSWORD")
      )["data"]["attributes"]["token"]
    end

    def base_uri
      ENV.fetch("REWARDS_BASE_URI", DEFAULT_BASE_URL)
    end
  end
end
