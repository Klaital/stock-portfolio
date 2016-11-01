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
      logger.info("Updating stock #{p.dataset}.#{p.symbol} for user #{p.user.email}")
      p.update_from_quandl
      logger.debug("Stock updated: #{p.current_value} @ #{p.last_updated}")
      p.save
    end
  end

  def current_value
    sum = 0
    stock_positions.each do |p|
      sum += p.current_value
    end
    sum
  end
  def current_value_dollars
    current_value.to_f / 100.0
  end
  def current_value_string
    dollars = (current_value / 100).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    pennies = (current_value % 100).to_s.rjust(2, '0')
    "#{dollars}.#{pennies}"
  end

  # Compute how much money has been gained or lost on this position.
  def current_yield
    sum = 0
    stock_positions.each do |p|
      sum += p.current_yield
    end
    sum
  end
  def current_yield_dollars
    current_yield.to_f / 100.0
  end
  def current_yield_string
    dollars = (current_yield / 100).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    pennies = (current_yield % 100).to_s.rjust(2, '0')
    "#{dollars}.#{pennies}"
  end
  def current_yield_percent(rounding_places=2)
    # ((current_yield.to_f * 100.0) / (purchase_price * qty).to_f).round(rounding_places)
    "Coming Soon!"
  end

end
