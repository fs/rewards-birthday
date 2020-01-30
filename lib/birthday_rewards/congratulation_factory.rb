module BirthdayRewards
  class CongratulationFactory
    def initialize(template)
      @template = template
    end

    def congratulation(person)
      Congratulation.new(@template, person)
    end
  end
end
