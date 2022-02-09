require "rails_helper"

describe Deposit do
  describe ".call?" do
    context "when call is true" do
      let(:account) { create(:account) }
      let(:value) { 10.00 }

      it "create Deposit with valid params" do
        deposit = Deposit.new(value: value, recipient: account)
        expect(deposit.call?).to be_truthy
      end
    end
    context "when call is false" do
      let(:account) { create(:account) }
      let(:value) { -10.00 }

      it "not create Deposit with invalid params" do
        deposit = Deposit.new(value: value, recipient: account)
        expect(deposit.call?).to be_falsey
      end
    end
  end
end