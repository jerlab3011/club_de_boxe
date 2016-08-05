class Membership < ApplicationRecord
  belongs_to :user
  default_scope -> { order(end_date: :desc) }
  
  before_save :set_end_date, :set_price
  
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  validates :duration, presence: true  
  validates :start_date, presence: true
  
  DESCRIPTIONS = ["Illimité", "1 fois/semaine"]
  DURATIONS = [3, 6, 12]
  
  def set_end_date
    self.end_date = start_date + duration.months
  end
  
  def set_price
    if self.duration == 3 && self.description == "Illimité"
      self.price = 120
    elsif self.duration == 3 && self.description == "1 fois/semaine"
      self.price = 70
    elsif self.duration == 6 && self.description == "Illimité"
      self.price = 220
    elsif self.duration == 6 && self.description == "1 fois/semaine"
      self.price = 120
    elsif self.duration == 12 && self.description == "Illimité"
      self.price = 400
    elsif self.duration == 12 && self.description == "1 fois/semaine"
      self.price = 200
    end
  end
  
end
