require "date"

module BirthdayRewards
  class User
    def initialize(params)
      @username = params["username"]
      @email = params["email"]
      @birth_date = Date.strptime(params["birth-date"], "%Y-%m-%d")
    end

    attr_reader :username, :email, :birth_date

    def birthday?(date)
      date.present? &&
        date.year >= @birth_date.year &&
        date.month == @birth_date.month &&
        date.day == @birth_date.day
    end
  end
end
