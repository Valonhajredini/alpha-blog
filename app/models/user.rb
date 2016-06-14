class User < ActiveRecord::Base


  before_save {self.email = email.downcase}
  validates :username,  presence: true, length: {minimum: 3, maximum: 25},
            uniqueness: { casse_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 105},
      uniqueness: {case_sensitive: false},
      format: {with: VALID_EMAIL_REGEX }


  has_many :articles
  has_secure_password

end