class AccountsController < ApplicationController
  def index
    @accounts=Account.all
  end

  def show
   account_id
   @accounts=Account.find(params[:id])
   @commentable=@accounts
   @comments=@commentable.comments
   @comment=Comment.new
  end
   def new
     @account=Account.new 
   end
  def create
    @account = Account.create(account_params)
    if @account.valid?
      redirect_to accounts_index_path(@account)
    else
      render :new
    end
  end
 

  def edit
    account_id
  end
  def update
     account_id
     if @account.update(account_params)
      redirect_to account_path(@account)
     else
      render :edit
     end
  end
  def destroy
    Account.destroy(params[:id])
    
    redirect_to accounts_path
  end
  private

  def account_params
    params.require(:account).permit(:first_name,:last_name,:email,:mobileno)
  end

  def account_id
    @account=Account.find(params[:id])
  end

end
