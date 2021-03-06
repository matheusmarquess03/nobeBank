# frozen_string_literal: true

class Withdraw
  attr_reader :value, :recipient

  def initialize(value:, recipient:)
    @value = value
    @recipient = recipient
  end

  def call?
    ActiveRecord::Base.transaction do
      @recipient.update!(balance: new_balance)
      withdraw_params
    rescue ActiveRecord::RecordInvalid
      raise ActiveRecord::Rollback
    end
  end

  private

  def withdraw_params
    Transfer.create!(
      value: @value,
      recipient: @recipient,
      sender: @recipient,
      kind: Transfer.kinds[:withdraw]
    )
  end

  def new_balance
    @recipient.balance - @value.to_f
  end
end
