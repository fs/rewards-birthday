require "rewards"

module RewardsBirthday
  class Base
    DEFAULT_BASE_URL = "http://rewards.team/api/v1".freeze

    attr_reader :emails

    def initialize(emails = nil)
      @emails = emails

      Rewards::Client.base_uri(base_uri)
    end

    private

    def base_uri
      ENV.fetch("REWARDS_BASE_URI", DEFAULT_BASE_URL)
    end
  end
end
