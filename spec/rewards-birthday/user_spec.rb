require "date"

require "rewards-birthday/user"

describe RewardsBirthday::User do
  def user_birthday?(id, date)
    described_class.new(fixture_by_id("users", id)["attributes"]).birthday?(date)
  end

  describe ".birthday?" do
    context "when given birthday" do
      let(:birthday_date) { Date.new(2010, 5, 5) }

      it "returns true" do
        expect(user_birthday?(1, birthday_date)).to be_truthy
      end
    end

    context "when given regular date" do
      let(:some_date) { Date.new(2006, 10, 28) }

      it "returns false" do
        expect(user_birthday?(1, some_date)).to be_falsey
      end
    end

    context "when given nil" do
      it "returns false" do
        expect(user_birthday?(1, nil)).to be_falsey
      end
    end

    context "when no birth date passed to initialize" do
      let(:some_date) { Date.new(2020, 1, 1) }

      it "returns false" do
        [3, 4, 5].each do |user_id|
          expect(user_birthday?(user_id, some_date)).to be_falsey
        end
      end
    end
  end
end
