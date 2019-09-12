require "rewards"

module RewardsBamboohr
  class Bonus
    attr_reader :token, :users, :template

    def initialize(token:, template:)
      @token, @template = token, template
      @users = load_users(token)
    end

    def create_bonuses(users)
      users.each do |user|
        username = find_username(user)
        create_bonus(username, user) if username
      end
    end

    private

    def find_username(user)
      users.each do |user|
        return user["attributes"]["username"] if user["attributes"]["email"] == user["bestEmail"]
      end

      nil
    end

    def create_bonus(username, user)
      bonus = generate_from_template(username, user)

      Rewards::Client.new(token: token)
        .bot_create_bonus(bonus)
    end

    def load_users(token)
      Rewards::Client.new(token: token)
        .bot_users["data"]
    end

    def generate_from_template(username, user)
      template.generate(
        username: username,
        bamboohr_data: user
      )
    end
  end
end
