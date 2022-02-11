# frozen_string_literal: true

require 'rails_helper'

describe Transference do
  describe '.call?' do
    context 'when call is true' do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }

      before do
        @transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender
        )
      end

      it 'create transference with valid params' do
        expect(@transference.call?).to be_truthy
      end
    end
    context 'when call is false' do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { FFaker::Random.rand(10_000.0..50_000.0).round(2) }

      before do
        @transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender
        )
      end

      it 'not create Transference with invalid params' do
        expect(@transference.call?).to be_falsey
      end
    end

    context 'when is not working time' do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }
      let(:value_bigger_thousand) { FFaker::Random.rand(1000.0..1500.0).round(2) }
      let(:fee_bigger_thousand) { 10 }
      let(:fee_not_working_time) { 7 }

      before do
        travel_to Time.zone.parse('2022-02-06 23:00:00')
        @transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender
        )

        @transference_bigger_value = Transference.new(
          value: value_bigger_thousand,
          recipient: recipient,
          sender: sender
        )
        @new_balance_sender_not_working_time_bigger_thousand = sender.balance - value_bigger_thousand - fee_bigger_thousand - fee_not_working_time
        @new_balance_sender_not_working_time = sender.balance - value - fee_not_working_time
        @new_balance_recipient = recipient.balance + value_bigger_thousand
        @new_balance_recipient_lower = recipient.balance + value
      end

      it 'make transfers out of hours' do
        expect do
          @transference.call?
        end.to change(Transfer, :count).by(1)
      end

      it 'check if .call is true' do
        expect(@transference.call?).to be_truthy
      end

      it 'creates a transfer with a value greater than one thousand' do
        @transference_bigger_value.call?
        expect(sender.reload.balance).to eq(@new_balance_sender_not_working_time_bigger_thousand)
        expect(recipient.reload.balance).to eq(@new_balance_recipient)
      end

      it 'creates transfer with value less than one thousand' do
        @transference.call?
        expect(sender.reload.balance).to eq(@new_balance_sender_not_working_time)
        expect(recipient.reload.balance).to eq(@new_balance_recipient_lower)
      end
    end
    context 'when in working hours' do
      let(:recipient) { create(:account) }
      let(:sender) { create(:account) }
      let(:value) { FFaker::Random.rand(100.0..500.0).round(2) }
      let(:value_bigger_thousand) { FFaker::Random.rand(1000.0..1500.0).round(2) }
      let(:fee_bigger_thousand) { 10 }
      let(:fee_default) { 5 }

      before do
        travel_to Time.zone.parse('2022-02-9 10:00:00')
        @transference = Transference.new(
          value: value,
          recipient: recipient,
          sender: sender
        )

        @transference_bigger_value = Transference.new(
          value: value_bigger_thousand,
          recipient: recipient,
          sender: sender
        )
        @new_balance_sender_bigger_thousand = sender.balance - value_bigger_thousand - fee_bigger_thousand - fee_default
        @new_balance_sender = sender.balance - value - fee_default
        @new_balance_recipient = recipient.balance + value
        @new_balance_recipient_bigger_thousand = recipient.balance + value_bigger_thousand
      end

      it 'create transfer in working time' do
        expect do
          @transference.call?
        end.to change(Transfer, :count).by(1)
      end

      it 'check if .call is true' do
        expect(@transference.call?).to be_truthy
      end

      it 'creates transfer with a value greater than one thousand' do
        @transference_bigger_value.call?
        expect(sender.reload.balance).to eq(@new_balance_sender_bigger_thousand)
        expect(recipient.reload.balance).to eq(@new_balance_recipient_bigger_thousand)
      end

      it 'creates transfer with value less than one thousand' do
        @transference.call?
        expect(sender.reload.balance).to eq(@new_balance_sender)
        expect(recipient.reload.balance).to eq(@new_balance_recipient)
      end
    end
  end
end
