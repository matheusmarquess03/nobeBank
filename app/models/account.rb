class Account < ApplicationRecord
  belongs_to :user
  has_many :transfers

  validates_presence_of :account_number, :balance
  validates_numericality_of :balance, greater_than_or_equal_to: 0
  before_validation :generate_account_number

  private

  def generate_account_number
    if current_user.account.account_number.present?
      self.account_number = current_user.account.account_number
    else
     self.account_number = Random.rand(10...100)
    end
  end

end
