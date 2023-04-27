module Api
class PropertiesController < Api::ApplicationController

  def index
    @properties = Property.all
     render json: {property: @properties}
  end

  def show
    @property = Property.find_by(id: params[:id])
    if current_account.is_a? Account

      if @property.account_id == doorkeeper_token.resource_owner_id
        if @property.present?
        render json: @property, status: 200
    else
        render json: {error: " property is not exist"}
    end
    else
        render json:{error:"unauthorized"},status: :unauthorized
    end
  else
  render json: {error:"You are not allowed to updatee"},status: 403
  end
end

  def create
    @account = Account.find(doorkeeper_token.resource_owner_id)
          property= @account.properties.new(property_params)
            if property.save
              render json: property, status: :created
      
            else 
              render json: { error: post.errors.full_messages }, status: :unprocessable_entity
            end
            
  end


  def update
    @property = Property.find_by(id: params[:id])

    if @property.present?
      if current_account.is_a? Account
        if @property.account_id == doorkeeper_token.resource_owner_id
          if @property.update(property_params)
            render json: { message: "property id #{@property.id} is updated successfully" }
          else
            render json: { message: "property not updated" }
          end
        else
          render json: { error: "unauthorized" }, status: :unauthorized
        end
      else
        render json: { error: "You are not allowed to update" }, status: 403
      end
    else
      render json: { error: "Property not found" }, status: :not_found
    end

  end

  def destroy
    @property = Property.find_by(id: params[:id])

    if @property.present?
      if current_account.is_a? Account
        if @property.account_id == doorkeeper_token.resource_owner_id

          if @property.destroy
            render json: {message: "property deleted"}
          else
            render json: {message:"Property not deleted"}
          end
        else
           render json:{error:"unauthorized"},status: :unauthorized
        end
      else
        render json: {message:"You are not allowed to delete"},status: 403
      end
     else 
        render json: {message:"message-not-found"}
     end
  end


  private

  def property_params
    params.require(:property).permit(:name, :address, :price, :rooms, {images: []} , :account_id)
  end
end
end
