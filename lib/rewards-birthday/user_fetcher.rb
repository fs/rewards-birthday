require "active_support/core_ext/time/calculations"

module RewardsBirthday
  class UserFetcher
    attr_reader :employees

    def initialize(users)
      @employees = users
    end

    def today_birthdays
      @employees.each_with_object([]) do |employee, birthday_people|
        birthday_people << employee if today?(employee["birth_date"])
      end
    end

    def by_emails(emails)
      @employees.each_with_object([]) do |employee, people|
        people << employee if emails.include?(employee["email"])
      end
    end

    private

    def today?(date_string)
      date = valid_date?(date_string)
      date && month_day(date) == month_day(Date.today)
    end

    def month_day(date)
      date.strftime("%m-%d")
    end

    def valid_date?(date_string)
      Date.parse(date_string)
    rescue ArgumentError
      false
    end
  end
end
