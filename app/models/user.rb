class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  VALID_PHONE_REGEX = /\A\(?\d{3}\)?\s?-?\d{3}-?\d{4}\z/
  validates :phone, presence: true, format: {with: VALID_PHONE_REGEX }
  validates :adress, presence: true, length: { maximum: 255 }
  VALID_POSTAL_CODE_REGEX = /\A[a-z]\d[a-z]\s?\d[a-z]\d\z/i
  validates :postal_code, presence: true, format: {with: VALID_POSTAL_CODE_REGEX }
  validates :birth_date, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
