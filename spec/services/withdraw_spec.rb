require "rails_helper"

describe Withdraw do
  describe ".call?" do
    context "when call is true" do
      let(:account) { create(:account) }
      let(:value) { 10.00 }

      it "create Withdraw with valid params" do
        withdraw = Withdraw.new(value: value, recipient: account)
        expect(withdraw.call?).to be_truthy
      end
    end
    context "when call is false" do
      let(:account) { create(:account) }
      let(:value) { -10.00 }

      it "not create Withdraw with invalid params" do
        withdraw = Withdraw.new(value: value, recipient: account)
        expect(withdraw.call?).to be_falsey
      end
    end
  end
end