class Transfer < ApplicationRecord
  belongs_to :recipient, class_name: "Account"
  belongs_to :sender, class_name: "Account"

  enum kind: [:deposit, :withdraw, :transference]

  validates :kind, presence: true
  validates :value, presence: true
  validates_numericality_of :value, greater_than_or_equal_to: 0
end
