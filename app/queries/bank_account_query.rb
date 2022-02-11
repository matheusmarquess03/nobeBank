# frozen_string_literal: true

class BankAccountQuery
  def self.find_account_by_number(account_number)
    Account.find_by(account_number: account_number)
  end
end
