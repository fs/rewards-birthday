require "date"

require "birthday_rewards/user"

describe BirthdayRewards::User do
  let(:user) { described_class.new(fixture("users")[0]["attributes"]) }

  describe ".birthday?" do
    context "when given birthday" do
      let(:birthday_date) { Date.new(2010, 5, 5) }

      it "returns true" do
        expect(user.birthday?(birthday_date)).to be(true)
      end
    end

    context "when given regular date" do
      let(:some_date) { Date.new(2006, 10, 28) }

      it "returns false" do
        expect(user.birthday?(some_date)).to be(false)
      end
    end

    context "when given nil" do
      it "returns false" do
        expect(user.birthday?(nil)).to be(false)
      end
    end
  end
end
