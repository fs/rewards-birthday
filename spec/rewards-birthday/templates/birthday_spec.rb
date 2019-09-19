describe RewardsBirthday::Templates::Birthday do
  let(:username) { "Claire" }
  let(:template) do
    described_class.generate(username: username)
  end

  describe ".generate" do
    it "generates birthday template" do
      expect(template).to eq("+100 Happy Birthday @Claire")
    end
  end
end
