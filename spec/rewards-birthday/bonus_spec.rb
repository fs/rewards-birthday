describe RewardsBirthday::Bonus do
  let(:bonus) { described_class.new(token: "token", template: template) }
  let(:rewards_client) { instance_double(Rewards::Client) }
  let(:birthdays) { fixture("rewards_birthdays") }

  before do
    allow(Rewards::Client).to receive(:new) { rewards_client }
    allow(rewards_client).to receive(:bot_users) { fixture("users") }
  end

  describe "#create_bonuses" do
    context "when birthday template is set" do
      let(:template) { RewardsBirthday::Templates::Birthday }

      it "creates bonuses for birthdays" do
        expect(rewards_client).to receive(:bot_create_bonus).with("+100 Happy Birthday @john.smith")
        expect(rewards_client).not_to receive(:bot_create_bonus).with("+100 Happy Birthday @john.doe")

        bonus.create_bonuses(birthdays)
      end
    end
  end
end
