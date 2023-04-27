ActiveAdmin.register Property do
  permit_params :name, :address, :price, :rooms

  index do
    selectable_column
    id_column
    column :account
    column :name
    column :address
    column :price
    column :updated_at
    column :created_at
    actions
  end

end
