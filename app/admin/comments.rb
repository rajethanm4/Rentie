ActiveAdmin.register Comment do
  permit_params :content, :commentable_type, :commentable_id, :user_id

  scope :all
  
  scope :property, :default => true do |like|
    Comment.property
  end
  scope :account, :default => true do |like|
    Comment.account
  end
  filter :content,as: :string
  filter :commentable_type, as: :string
  filter :created_at
  index do
    selectable_column
    column :id
    column :content
    column :user_id
    column :commentable
    column :commentable_type
    column :created_at
    column :updated_at
    actions
  end
  
  
end

