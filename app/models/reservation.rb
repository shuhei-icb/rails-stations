class Reservation < ApplicationRecord
  belongs_to :schedule
  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :sheet_id, uniqueness: true, presence: true
  validates :schedule_id, presence: true
  validates :date, uniqueness: true, presence: true
end
