class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :payments, dependent: :destroy
  attr_accessor :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
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
  
  
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def self.search(search)
    where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", 
    "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
