require "date"

require "rewards"

require "birthday_rewards/user"

module BirthdayRewards
  class Base
    DEFAULT_BASE_URL = "http://rewards.team/api/v1".freeze

    def initialize
      Rewards::Client.base_uri(base_uri)
    end

    def create_birthday_bonus
      users = wrap_users(fetch_users)
      celebrants = birthday_celebrants(users)
      create_bonuses(celebrants)
    end

    def create_birthday_bonuses_for(emails)
      users = wrap_users(fetch_users)
      celebrants = white_list_celebrants(emails, users)
      create_bonuses(celebrants)
    end

    private

    def fetch_users
      client.bot_users["data"].map { |data| data["attributes"] }
    end

    def wrap_users(users)
      users.map { |user| User.new(user) }
    end

    def birthday_celebrants(users)
      today = Date.today
      users.select { |user| user.birthday?(today) }
    end

    def white_list_celebrants(email_white_list, users)
      users.select { |user| email_white_list.include?(user.email) }
    end

    def create_bonuses(users)
      users.each do |user|
        client.bot_create_bonus(bonus(user))
      end
    end

    def bonus(user)
      format(reward_template, username: user.username)
    end

    def client
      @client ||= Rewards::Client.new(token: token)
    end

    def token
      @token ||= Rewards::Client.new.bot_create_token(
        ENV.fetch("REWARDS_BOT_NAME"),
        ENV.fetch("REWARDS_BOT_PASSWORD")
      )["data"]["attributes"]["token"]
    end

    def base_uri
      ENV.fetch("REWARDS_BASE_URI", DEFAULT_BASE_URL)
    end

    def reward_template
      @reward_template ||= ENV.fetch("REWARDS_BIRTHDAY_TEMPLATE")
    end
  end
end
