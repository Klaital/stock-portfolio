class User < ApplicationRecord
  has_many :stock_positions, dependent: :destroy
  has_many :api_keys, dependent: :destroy

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

  # Returns the hash digest of the given string.
  def User.digest(s)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(s, cost: cost)
  end

  def update_positions
    stock_positions.each do |p|
      p.update_from_quandl
      p.save
    end
  end
end
