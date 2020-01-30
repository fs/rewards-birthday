module BirthdayRewards
  class Person
    attr_reader :name

    def initialize(name, birthdate)
      @name = name
      @birthdate = birthdate
    end

    def birthday?(date)
      date.present? && @birthdate.month == date.month && @birthdate.day == date.day
    end
  end
end
