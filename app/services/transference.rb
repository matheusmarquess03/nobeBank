# frozen_string_literal: true

class Transference
  attr_reader :value, :recipient, :sender

  def initialize(value:, recipient:, sender:)
    @value = value
    @recipient = recipient
    @sender = sender
  end

  def call?
    ActiveRecord::Base.transaction do
      remove_from_sender
      add_to_recipient
      transfer_params
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::Rollback
    end
  end

  private

  def transfer_params
    Transfer.create!(
      value: @value,
      recipient: @recipient,
      sender: @sender,
      kind: Transfer.kinds[:transference]
    )
  end

  def remove_from_sender
    @sender.update!(balance: new_balance_sender)
  end

  def add_to_recipient
    @recipient.update!(balance: new_balance_recipient)
  end

  def new_balance_sender
    @sender.balance - (@value.to_f + transfer_fee_calculation + transference_over_thousand)
  end

  def new_balance_recipient
    @recipient.balance + @value.to_f
  end

  def transference_over_thousand
    @value.to_f > 1000 ? 10 : 0
  end

  def its_weekend?
    time = Time.now.strftime('%H%M')
    day = Time.now.strftime('%u')

    day.between?('6', '7') || !time.between?('0900', '1800')
  end

  def transfer_fee_calculation
    its_weekend? ? 7 : 5
  end
end
