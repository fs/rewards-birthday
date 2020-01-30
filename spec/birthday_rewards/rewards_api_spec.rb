require "date"

require "spec_helper"

require "birthday_rewards/person"
require "birthday_rewards/rewards_api"

describe BirthdayRewards::RewardsAPI do
  let(:rewards_client) { instance_double(Rewards::Client) }
  let(:api) { described_class.new(rewards_client) }
  let(:some_date) { Date.new(1970, 1, 1) }

  before { allow(rewards_client).to receive(:bot_users) { fixture("people") } }

  describe ".people_with_birthdates" do
    it "returns people with birthdays" do
      api.people_with_birthdates.each do |person|
        expect { person.birthday?(some_date) }.not_to raise_error
      end
    end
  end
end
