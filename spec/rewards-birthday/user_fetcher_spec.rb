describe RewardsBirthday::UserFetcher do
  let(:fetcher) { described_class.new(fixture("rewards_users")) }

  describe "#today_birthdays" do
    it "returns a birthday person" do
      Timecop.freeze("1991-01-01") do
        expect(fetcher.today_birthdays.first).to include("id" => 123)
        expect(fetcher.today_birthdays.size).to eql(1)
      end
    end
  end

  describe "#by_emails" do
    let(:emails) { ["john.smith@example.com"] }

    it "returns person with certain email" do
      expect(fetcher.by_emails(emails).first).to include("id" => 124)
      expect(fetcher.by_emails(emails).size).to eql(1)
    end
  end
end
