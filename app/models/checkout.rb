class Checkout < ApplicationRecord
  belongs_to :user
  belongs_to :device

  enum action: { checkout: 'checkout', checkin: 'checkin' }
  validates :action, inclusion: { in: actions.keys }
  #validates :user, uniqueness: { scope: :device }
end
