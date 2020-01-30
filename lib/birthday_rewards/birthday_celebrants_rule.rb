module BirthdayRewards
  class BirthdayCelebrantsRule
    def initialize(date:)
      @date = date
    end

    def apply(people)
      BirthdayCelebrants.new(people, date: @date)
    end
  end
end
