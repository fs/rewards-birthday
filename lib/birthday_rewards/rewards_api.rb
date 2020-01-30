require "date"

require_relative "person"

module BirthdayRewards
  class RewardsAPI
    def initialize(rewards_client)
      @client = rewards_client
    end

    def people_with_birthdates
      fetch_users
        .map do |user|
          name = user["username"]
          birthdate = Date.strptime(user["birth-date"], DATE_FORMAT)
          Person.new(name, birthdate)
        end
    end

    def create_bonus(text)
      @client.bot_create_bonus(text)
    end

    private

    DATE_FORMAT = "%Y-%m-%d".freeze

    def fetch_users
      @client.bot_users["data"].map { |data| data["attributes"] }
    end
  end
end
