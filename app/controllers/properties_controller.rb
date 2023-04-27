class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]
  before_action :authenticate_account!, only: [:new,:create,:destroy]
  before_action :set_sidebar, except: [:show]
  
  def index
    @properties = Property.all
  end

  def search
    @query = params[:q]
    @properties = Property.where('address LIKE ?', "%#{@query}%")
  end  
  
  def show
    @agent = @property.account
    @properties=Property.find(params[:id])
    @commentable=@properties
    @comments=@commentable.comments
    @comment=Comment.new
  end

  
  def new
    @property = Property.new
  end

  
  def edit
  end

  
  def create
    @property = Property.new(property_params)
    @property.account_id = current_account.id

    respond_to do |format|
      if @property.save
        format.html { redirect_to property_url(@property), notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to property_url(@property), notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def set_property
      @property = Property.find(params[:id])
    end
   
    def set_sidebar
      @show_sidebar=true
    end  
    
    def property_params
      params.require(:property).permit(:name, :address, :price, :rooms, images: [])
    end
end
