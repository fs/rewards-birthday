require "date"

require "spec_helper"

require "birthday_rewards/congratulation"
require "birthday_rewards/person"

describe BirthdayRewards::Congratulation do
  let(:person) { BirthdayRewards::Person.new("anonymous", Date.new(1970, 1, 1)) }
  let(:congratulation) { described_class.new("Happy Birthday, %<name>s!", person) }

  describe ".to_s" do
    it "returns congratulation for given person" do
      expect(congratulation.to_s).to eq("Happy Birthday, anonymous!")
    end
  end
end
