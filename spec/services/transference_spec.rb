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

    context "when is not working time" do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }
      let(:value_bigger_thousand) { FFaker::Random.rand(1000.0..1500.0).round(2) }

      before do
        travel_to Time.zone.parse("2022-02-06 23:00:00")
        @transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender,
        )

        @transference_bigger_value = Transference.new(
          value: value_bigger_thousand,
          recipient: recipient,
          sender: sender,
        )
      end

      it "make transfers out of hours" do
        expect {
          @transference.call?
        }.to change(Transfer, :count).by(1)
      end

      it "check if .call is true" do
        expect(@transference.call?).to be_truthy
      end

      it "creates a transfer with a value greater than one thousand" do
        new_balance_sender = sender.balance - value_bigger_thousand - 10 - 7
        new_balance_recipient = recipient.balance + value_bigger_thousand
        @transference_bigger_value.call?
        expect(sender.reload.balance).to eq(new_balance_sender)
        expect(recipient.reload.balance).to eq(new_balance_recipient)
      end

      it "creates transfer with value less than one thousand" do
        new_balance_sender = sender.balance - value - 7
        new_balance_recipient = recipient.balance + value
        @transference.call?
        expect(sender.reload.balance).to eq(new_balance_sender)
        expect(recipient.reload.balance).to eq(new_balance_recipient)
      end
    end
    context "when in working hours" do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }
      let(:value_bigger_thousand) { FFaker::Random.rand(1000.0..1500.0).round(2) }

      before do
        travel_to Time.zone.parse("2022-02-9 10:00:00")
        @transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender,
        )

        @transference_bigger_value = Transference.new(
          value: value_bigger_thousand,
          recipient: recipient,
          sender: sender,
        )
      end

      it "create transfer in working time" do
        expect {
          @transference.call?
        }.to change(Transfer, :count).by(1)
      end

      it "check if .call is true" do
        expect(@transference.call?).to be_truthy
      end

      it "creates transfer with a value greater than one thousand" do
        new_balance_sender = sender.balance - value_bigger_thousand - 10 - 5
        new_balance_recipient = recipient.balance + value_bigger_thousand
        @transference_bigger_value.call?
        expect(sender.reload.balance).to eq(new_balance_sender)
        expect(recipient.reload.balance).to eq(new_balance_recipient)
      end

      it "creates transfer with value less than one thousand" do
        new_balance_sender = sender.balance - value - 5
        new_balance_recipient = recipient.balance + value
        @transference.call?
        expect(sender.reload.balance).to eq(new_balance_sender)
        expect(recipient.reload.balance).to eq(new_balance_recipient)
      end
    end
  end
end