class User < ApplicationRecord
  attr_accessor :remember_token, :reset_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :suggests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: {maximum: Settings.user_models.max_length_name}
  validates :email, presence: true, length: {maximum: Settings.user_models.max_length_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user_models.min_length_password}, allow_nil: true
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
