require "date"

require "spec_helper"

require "birthday_rewards/application"
require "birthday_rewards/birthday_celebrants_rule"
require "birthday_rewards/birthday_celebrants"
require "birthday_rewards/congratulation"
require "birthday_rewards/congratulation_factory"
require "birthday_rewards/person"

describe BirthdayRewards::Application do
  let(:rewards_client) { instance_double(Rewards::Client) }
  let(:api) { BirthdayRewards::RewardsAPI.new(rewards_client) }

  let(:someones_birthday) { Date.new(2000, 1, 2) }
  let(:celebrants_rule) { BirthdayRewards::BirthdayCelebrantsRule.new(date: someones_birthday) }
  let(:congratulation_factory) { BirthdayRewards::CongratulationFactory.new("Happy birthday!") }
  let(:application) { described_class.new(api, congratulation_factory, celebrants_rule) }

  before do
    allow(rewards_client).to receive(:bot_users) { fixture("people") }
    allow(rewards_client).to receive(:bot_create_bonus)
  end

  describe ".run" do
    it "congratulates birthday celebrants" do
      application.run
      expect(rewards_client).to have_received(:bot_create_bonus).exactly(3).times
    end
  end
end
