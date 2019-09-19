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
        create_bonus(username) if username
      end
    end

    private

    def create_bonus(username)
      bonus = generate_from_template(username)

      Rewards::Client.new(token: token)
        .bot_create_bonus(bonus)
    end

    def generate_from_template(username)
      template.generate(username: username)
    end
  end
end
