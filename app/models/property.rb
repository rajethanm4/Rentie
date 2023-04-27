class Property < ApplicationRecord
    belongs_to :account
    has_many_attached :images
    has_many :comments, as: :commentable  

    validates :name, :address, presence: true
    validates :name, uniqueness: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
end
