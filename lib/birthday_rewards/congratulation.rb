module BirthdayRewards
  class Congratulation
    def initialize(template, person)
      @person = person
      @template = template
    end

    def to_s
      format(@template, name: @person.name)
    end
  end
end
