class Lane < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def average_rating
    ratings = self.reviews.map(&:rating)
    return ratings.length.zero? ? 0 : ratings.sum / ratings.length
  end

  def color_update!
    case self.average_rating
    when 1, 2
      self.color = "#DB4437"
    when 3
      self.color = "#F4B400"
    when 4, 5
      self.color = "#0F9D58"
    else
      self.color = "#616161"
    end
    self.save!
  end
end
