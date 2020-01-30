require "date"

require "spec_helper"

require "birthday_rewards/birthday_celebrants"
require "birthday_rewards/person"

describe BirthdayRewards::BirthdayCelebrants do
  let(:chris) { BirthdayRewards::Person.new("Chris", Date.new(1970, 1, 2)) }
  let(:julia) { BirthdayRewards::Person.new("Julia", Date.new(1979, 2, 1)) }
  let(:celebrants) { described_class.new([chris, julia], date: Date.new(1970, 1, 2)) }

  describe ".each" do
    it "returns celebrants" do
      celebrants.each do |person|
        expect(person).to be(chris)
      end
    end

    it "doesn't return not celebrants" do
      celebrants.each do |person|
        expect(person).not_to be(julia)
      end
    end
  end
end
