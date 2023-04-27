class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :normalize_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :appointments
  has_many :accounts, through: :appointments   
  has_many :comments     
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  private 

  def normalize_name
    self.first_name = first_name.downcase.titleize if first_name.present?
    self.last_name = last_name.downcase.titleize if last_name.present?
  end
  
end
