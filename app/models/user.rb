class User < ApplicationRecord
  before_save do
    self.email = email.downcase
    self.slug = slug.downcase
  end

  VALID_SLUG_REGEX = /\A[\w+\-\._\d]+\z/i
  validates :slug,
            presence: true,
            length: {maximum: 50},
            format: {with: VALID_SLUG_REGEX},
            uniqueness: {case_sensitive: false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 6 }
end
