require "rails_helper"

describe Deposit do
  describe ".call?" do
    context "when call is true" do
      let(:account) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }

      it "create Deposit with valid params" do
        deposit = Deposit.new(value: value, recipient: account)
        expect(deposit.call?).to be_truthy
      end
    end
    context "when call is false" do
      let(:account) { create(:account) }
      let(:value) { FFaker::Random.rand(-100.0..-10.0) }

      it "not create Deposit with invalid params" do
        deposit = Deposit.new(value: value, recipient: account)
        expect(deposit.call?).to be_falsey
      end
    end

    context "when the deposit is made" do
      let(:account) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }
      before do
        @deposit = Deposit.new(value: value, recipient: account)
      end
      it "create deposit" do
        new_balance_recipient = account.balance + value
        @deposit.call?
        expect(account.reload.balance).to eq(new_balance_recipient)
      end
    end
  end
end