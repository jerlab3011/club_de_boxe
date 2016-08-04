class User < ApplicationRecord
  before_save { email.downcase! }
  before_save :default_values
  
  default_scope -> { order(last_name: :asc) }
  
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :first_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  VALID_PHONE_REGEX = /\A\(?\d{3}\)?\s?-?\d{3}-?\d{4}\z/
  validates :phone, presence: true, format: {with: VALID_PHONE_REGEX }
  validates :address, presence: true, length: { maximum: 255 }
  VALID_POSTAL_CODE_REGEX = /\A[a-z]\d[a-z]\s?\d[a-z]\d\z/i
  validates :postal_code, presence: true, format: {with: VALID_POSTAL_CODE_REGEX }
  validates :birth_date, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  VALID_GENDER_REGEX = /\A[MF]\z/
  validates :gender, presence: true, format: {with: VALID_GENDER_REGEX}
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def full_name
    self.last_name + ", " + self.first_name
  end
  
  def default_values
    self.total = 0.00
  end
end
