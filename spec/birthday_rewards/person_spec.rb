require "date"

require "spec_helper"

require "birthday_rewards/person"

describe BirthdayRewards::Person do
  let(:current_date) { Date.new(1970, 1, 1) }
  let(:person) { described_class.new("anonymous", current_date) }

  describe ".birthday?" do
    context "when given birthday" do
      let(:birthday_date) { Date.new(2010, 1, 1) }

      it "responds with true" do
        expect(person.birthday?(birthday_date)).to be(true)
      end
    end

    context "when given day different from birthday" do
      let(:regular_date) { Date.new(current_date.year + 1, 12, 31) }

      it "responds with false" do
        expect(person.birthday?(regular_date)).to be(false)
      end
    end

    context "when given nil" do
      it "responds with false" do
        expect(person.birthday?(nil)).to be(false)
      end
    end
  end
end
