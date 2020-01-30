module BirthdayRewards
  class BirthdayCelebrants
    def initialize(source, date:)
      @all_people = source
      @date = date
    end

    def each
      @all_people
        .filter { |person| person.birthday?(@date) }
        .each { |person| yield person }
    end
  end
end
