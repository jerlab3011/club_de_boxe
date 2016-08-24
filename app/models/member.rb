class Member < ApplicationRecord
  belongs_to :user
  has_many :memberships, dependent: :destroy
  
  default_scope -> { order(last_name: :asc) }
  
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :first_name,  presence: true, length: { maximum: 50 }
  VALID_PHONE_REGEX = /\A\(?\d{3}\)?\s?-?\d{3}-?\d{4}\z/
  validates :phone, presence: true, format: {with: VALID_PHONE_REGEX }
  validates :address, presence: true, length: { maximum: 255 }
  VALID_POSTAL_CODE_REGEX = /\A[a-z]\d[a-z]\s?\d[a-z]\d\z/i
  validates :postal_code, presence: true, format: {with: VALID_POSTAL_CODE_REGEX }
  validates :birth_date, presence: true
  VALID_GENDER_REGEX = /\A[MF]\z/
  validates :gender, presence: true, format: {with: VALID_GENDER_REGEX}
  validates :user_id, presence: true
  
  def full_name
    self.last_name + ", " + self.first_name
  end


  def self.search(search)
    where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", 
    "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
