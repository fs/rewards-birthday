module RewardsBirthday
  module Templates
    class Base
      attr_reader :username

      def self.generate(username:)
        new(username).generate
      end

      def initialize(username)
        @username = username
      end
    end
  end
end
