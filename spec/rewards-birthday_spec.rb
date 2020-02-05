describe RewardsBirthday do
  let(:rewards_client) { instance_double(Rewards::Client) }

  before do
    allow(Rewards::Client).to receive(:new) { rewards_client }
    allow(rewards_client).to receive(:bot_users) { fixture("rewards_users") }
    allow(rewards_client).to receive(:bot_create_token) { fixture("rewards_token") }
    allow(rewards_client).to receive(:bot_create_bonus)
  end

  describe ".create_birthday_bonus" do
    it "creates bonuses for celebrants" do
      Timecop.freeze("2020-01-01") do
        described_class.create_birthday_bonuses
        expect(rewards_client).to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.smith")
      end
    end

    it "skips not celebrants" do
      Timecop.freeze("2020-01-01") do
        described_class.create_birthday_bonuses
        expect(rewards_client).not_to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.doe")
      end
    end
  end

  describe ".create_birthday_bonuses_for" do
    celebrants_emails_list = ["john.doe@example.com"]

    it "creates bonuses for those who is in white list" do
      described_class.create_birthday_bonuses_for(celebrants_emails_list)
      expect(rewards_client).to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.doe")
    end

    it "skips non-white-list people" do
      described_class.create_birthday_bonuses_for(celebrants_emails_list)
      expect(rewards_client).not_to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.smith")
    end
  end
end