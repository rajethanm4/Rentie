ActiveAdmin.register Appointment do
 permit_params :user_id, :account_id, :date
 scope :all

 scope :for_date, default: true do |scope|
 scope.for_date(Date.today)
 end 
 filter :date
 index do
  selectable_column
  id_column
  column :account
  column :user_id
  column :date
  column :updated_at
  column :created_at
  actions
end
end
