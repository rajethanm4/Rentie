class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :account
  scope :for_date, ->(date) { where(date: date) }

  before_validation :set_default_date, if: -> { self.date.nil? }
  validate :date_cannot_be_in_the_past
 
  private

  def set_default_date
    self.date = Date.today
  end
  
  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end

end
