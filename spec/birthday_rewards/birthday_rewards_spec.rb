describe BirthdayRewards::Base do
  let(:users) { fixture("users") }
  let(:base) { described_class.new }
  let(:rewards_client) { instance_double(Rewards::Client) }

  before do
    allow(Rewards::Client).to receive(:new) { rewards_client }
    allow(rewards_client).to receive(:bot_users) { { "data" => fixture("users") } }
    allow(rewards_client).to receive(:bot_create_token).and_return("data" => { "attributes" => { "token" => "123" } })
    allow(rewards_client).to receive(:bot_create_bonus)
  end

  describe ".create_birthday_bonus" do
    it "creates bonuses for celebrants" do
      Timecop.freeze("2020-01-01") do
        base.create_birthday_bonus
        expect(rewards_client).to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.smith")
      end
    end

    it "skips not celebrants" do
      Timecop.freeze("2020-01-01") do
        base.create_birthday_bonus
        expect(rewards_client).not_to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.doe")
      end
    end
  end

  describe ".create_birthday_bonuses_for" do
    celebrants_emails_list = ["john.doe@example.com"]

    it "creates bonuses for those who is in white list" do
      base.create_birthday_bonuses_for(celebrants_emails_list)
      expect(rewards_client).to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.doe")
    end

    it "skips non-white-list people" do
      base.create_birthday_bonuses_for(celebrants_emails_list)
      expect(rewards_client).not_to have_received(:bot_create_bonus).with("+100 Happy Birthday @john.smith")
    end
  end
end
