class PublicController < ApplicationController
  def main
    @properties=Property.all
  end  
end
