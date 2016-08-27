class Membership < ApplicationRecord
  belongs_to :member
  default_scope -> { order({end_date: :desc}) }
  
  before_save :set_end_date, :set_price
  
  validates :member_id, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  validates :duration, presence: true  
  validates :start_date, presence: true
  
  DESCRIPTIONS = ["Illimité", "1 fois/semaine"]
  DURATIONS = [3, 6, 12]
  
  def set_end_date
    self.end_date = start_date + duration.months
  end
  
  def set_price
    @member = Member.find(self.member_id)
    if @member.birth_date > (self.start_date - 18.years)
      self.description = self.description + " (jeune)"
    end
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
    elsif self.duration == 3 && self.description == "Illimité (jeune)"
      self.price = 85
    elsif self.duration == 3 && self.description == "1 fois/semaine (jeune)"
      self.price = 60
    elsif self.duration == 6 && self.description == "Illimité (jeune)"
      self.price = 150
    elsif self.duration == 6 && self.description == "1 fois/semaine (jeune)"
      self.price = 100
    elsif self.duration == 12 && self.description == "Illimité (jeune)"
      self.price = 250
    elsif self.duration == 12 && self.description == "1 fois/semaine (jeune)"
      self.price = 170
    end
  end
  
  def send_expiration_reminder_email
    UserMailer.expiration_reminder(self).deliver_now
  end
  
end
