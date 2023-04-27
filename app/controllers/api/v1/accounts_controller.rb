class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @accounts=Account.all
    render json: {account: @accounts}
  end

  def show
    @accounts=Account.find(params[:id])
    render json: {account: @accounts}
  end

  def create
  end

  private

  def account_id
    @account=Account.find(params[:id])
  end
end
