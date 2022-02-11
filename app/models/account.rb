class Account < ApplicationRecord
  belongs_to :user
  has_many :transfers

  validates_presence_of :account_number, :balance
  validates_numericality_of :balance, greater_than_or_equal_to: 0
  before_validation :generate_account_number

  private

  def generate_account_number
    self.account_number = '%05d' % user.id if user
  end
end
