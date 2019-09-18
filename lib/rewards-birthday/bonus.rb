require "rewards"

module RewardsBirthday
  class Bonus
    attr_reader :token, :template

    def initialize(token:, template:)
      @token, @template = token, template
    end

    def create_bonuses(users)
      users.each do |user|
        username = user["attributes"]["username"]
        create_bonus(username, user) if username
      end
    end

    private

    def create_bonus(username, user)
      bonus = generate_from_template(username, user)

      Rewards::Client.new(token: token)
        .bot_create_bonus(bonus)
    end

    def generate_from_template(username, user)
      template.generate(
        username: username,
        bamboohr_data: user
      )
    end
  end
end
