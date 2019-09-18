module RewardsBirthday
  module Templates
    class Base
      attr_reader :username, :user_data

      def self.generate(username:, user_data:)
        new(username, user_data).generate
      end

      def initialize(username, user_data)
        @username, @user_data = username, user_data
      end
    end
  end
end
