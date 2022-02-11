require "rails_helper"

describe Withdraw do
  describe ".call?" do
    context "when call is true" do
      let(:account) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }

      before do
        @withdraw = Withdraw.new(value: value, recipient: account)
      end

      it "create Withdraw with valid params" do
        expect(@withdraw.call?).to be_truthy
      end
    end
    context "when call is false" do
      let(:account) { create(:account) }
      let(:value) { FFaker::Random.rand(10000.0..50000.0).round(2) }

      before do
        @withdraw = Withdraw.new(value: value, recipient: account)
      end

      it "not create Withdraw with invalid params" do
        expect(@withdraw.call?).to be_falsey
      end
    end

    context "when withdraw is made" do
      let(:account) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }

      before do
        @withdraw = Withdraw.new(value: value, recipient: account)
      end

      it "create withdraw" do
        new_balance_recipient = account.balance - value
        @withdraw.call?
        expect(account.reload.balance).to eq(new_balance_recipient)
      end
    end
  end
end