class User < ApplicationRecord
  SIGN_UP_PARAMS = [:name, :address, :phone, :email, :password,
    :password_confirmation].freeze
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :confirmable, :recoverable, :lockable
  attr_accessor :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save{email.downcase!}

  has_many :comments, dependent: :destroy
  has_many :rattings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :suggests, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.maximum.name}
  validates :address, presence: true,
    length: {maximum: Settings.maximum.address}
  validates :phone, presence: true, length: {maximum: Settings.maximum.phone}
  validates :email, presence: true, length: {maximum: Settings.maximum.email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.minimum.pass},
    allow_nil: true

  enum role: {member: 0, admin: 1}

  scope :newest, ->{order created_at: :DESC}
  scope :search, ->(key) do
    where "name LIKE ? OR email LIKE ?", "%#{key}%", "%#{key}%"
  end
end
