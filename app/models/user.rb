class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :email, presence: true
  validates :password, presence: true
  validates_uniqueness_of :email 

  has_one :account
  after_create :create_account

  def active_for_authentication?
    super && account.enabled?
  end

  private

  def create_account
    @account = Account.new(user: self, balance: 0)
    unless @account.save
      raise "A conta não pode ser criada."
    end
  end
end
