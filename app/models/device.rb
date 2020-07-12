class Device < ApplicationRecord
  validates :tag, uniqueness: { case_sensitive: false }
  validates :category, presence: true
  validates :make, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :memory, presence: true
  validates :os, presence: true

  has_many :checkouts, dependent: :delete_all
  has_many :users, through: :checkouts

  def checkout_logs
    self.checkouts
  end
end