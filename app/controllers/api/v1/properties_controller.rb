class Api::V1::PropertiesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @properties = Property.all
    render json: { properties: @properties }
  end

  def show
    @properties = Property.find_by(id: params[:id])

    if @properties
      render json: { property: @properties }
    else
      render json: { error: 'Property not found' }, status: :not_found
    end
  end

  def create
    @property = Property.new(property_params)

    if @property.save
      render json: @property, status: :created
    else
      render json: { error: @property.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @property = Property.find_by(id: params[:id])

    if @property
      if @property.update(property_params)
        render json: { property: @property }
      else
        render json: { error: @property.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Property not found' }, status: :not_found
    end
  end

  def destroy
    @property = Property.find_by(id: params[:id])

    if @property
      @property.destroy
      head :no_content
    else
      render json: { error: 'Property not found' }, status: :not_found
    end
  end

  def property_comments
    property = Property.find_by(id: params[:id])

    if property
      count1 = property.comments.count
      render json: { no_of_comments_on_properties: count1 }
    else
      render json: { error: 'Property not found' }, status: :not_found
    end
  end

  private

  def property_params
    params.require(:property).permit(:name, :address, :price, :rooms, { images: [] }, :account_id)
  end
end
