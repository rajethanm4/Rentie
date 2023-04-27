class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  scope :property, ->{ where(:commentable_type => 'Property') }
  scope :account, -> { where(:commentable_type => 'Account') }


  before_save :convert_body_to_lowercase

  validates :content, presence: true
  validates :user, presence: true
  validates :commentable, presence: true

  private

  def convert_body_to_lowercase
    self.content = content.downcase
  end
end

