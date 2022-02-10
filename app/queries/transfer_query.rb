class TransferQuery
  def self.find_between_dates(inital_date, final_date, account)
    Transfer.where(created_at: initial_date.beginning_of_day..final_date.end_of_day, account: account)
  end
end