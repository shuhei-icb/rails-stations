class Movie < ApplicationRecord
  has_many :schedules
  validates :name, uniqueness: true

  def self.search(keyword)
    if keyword != ""
      self.where(['name LIKE(?) OR description LIKE(?)',"%#{keyword}%","%#{keyword}%"])      
    else
      self.all
    end
  end

end
