ActiveAdmin.register Account do
  permit_params :first_name, :last_name, :email, :mobileno
  
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :mobileno
    column :updated_at
    column :created_at
    actions
  end

  filter :email
  filter :created_at
  filter :first_name
  filter :last_name
  filter :mobileno
  filter :properties
  
end
