class Movie < ApplicationRecord
  validates :name, uniqueness: true

  def self.search(keyword)
    if keyword != ""
      self.where(['name LIKE(?) OR description LIKE(?)',"%#{keyword}%","%#{keyword}%"])      
    else
      self.all
    end
  end

end
