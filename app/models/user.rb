# frozen_string_literal: true

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
    super && account.active?
  end

  private

  def create_account
    @account = Account.new(user: self, balance: 0)
    raise 'A conta não pode ser criada.' unless @account.save
  end
end
