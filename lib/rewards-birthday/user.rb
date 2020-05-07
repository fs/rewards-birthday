require "date"

module RewardsBirthday
  class User
    attr_reader :params
    private :params

    def initialize(params)
      @params = params
    end

    def email
      params["email"]
    end

    def username
      params["username"]
    end

    def birth_date
      return nil if params["birth-date"].blank?

      Date.strptime(params["birth-date"], "%Y-%m-%d")
    end

    def birthday?(date = Date.today)
      return false if date.blank? || birth_date.blank?

      date.year >= birth_date.year &&
        date.month == birth_date.month &&
        date.day == birth_date.day
    end
  end
end
