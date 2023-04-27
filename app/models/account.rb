class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :normalize_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
     
  has_many :appointments
  has_many :users, through: :appointments
  has_many :properties     
  has_many :comments, as: :commentable  
  validates :first_name,:last_name,:email, presence: true
  validate :password_format
  def password_format
    unless password.match?(/^(?=.*[A-Z])(?=.*\d).+$/)
      errors.add :password, 'must contain at least one uppercase letter and one digit'
    end
  end  
  def full_name
   "#{first_name} #{last_name}"
  end

  def company
    "test company"
  end  


  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    account = Account.find_for_authentication(email: email)
    account&.valid_password?(password) ? account : nil
  end

  private 

  def normalize_name
    self.first_name = first_name.downcase.titleize if first_name.present?
    self.last_name = last_name.downcase.titleize if last_name.present?
  end
end
