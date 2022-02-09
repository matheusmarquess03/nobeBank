require "rails_helper"

describe Transference do
  describe ".call?" do
    context "when call is true" do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { 100.00 }

      it "create transference with valid params" do
        transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender,
        )
        expect(transference.call?).to be_truthy
      end
    end
    context "when call is false" do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { -10.0 }

      it "not create transference with invalid params" do
        transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender,
        )
        expect(transference.call?).to be_falsey
      end
    end
  end
end