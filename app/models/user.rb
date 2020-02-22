class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_one :booking
  scope :admin, -> { where(admin: true )}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :name,      presence: true, length: { minimum: 3 }
  validates :email,     presence: true, length: { maximum: 105 }, uniqueness: { scope: :provider, case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password,  confirmation: { case_sensitive: true }, if: ->{ password.present? }

  def self.from_omniauth(auth)

    where(auth.slice( "uid")).first || create_from_omniauth(auth)
  end
   
  def self.create_from_omniauth(auth)
    
    create! do |user|
      user.provider = auth["provider"],
      user.uid = auth["uid"],
      user.name = auth["info"]["name"],
      user.email =  auth["info"]["email"],
      user.password = auth["uid"],
      user.password_confirmation = auth["uid"]
    end
  end
end