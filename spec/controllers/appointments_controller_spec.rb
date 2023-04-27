require 'rails_helper'
RSpec.describe AppointmentsController, type: :controller do
    let!(:user) { create(:user) }
    let!(:account) { create(:account) }
    let(:appointment1) { create(:appointment, user: user,account: account) }
    let(:appointment2) { create(:appointment, user: user,account: account) }

    #rspec for get index
    describe "GET #index" do
    before(:each) do
        sign_in(user)
    end
        it "assigns appointents to user" do
            get :index
            expect(assigns(:appointments)).to eq([appointment1])
        end
   end

   describe "GET #show" do
      it "assigns " do
        get :show, params: { format: account.id}
        expect(assigns(:account)).to eq(account)
      end
    end  
    

    describe "POST #create" do 
        before(:each) do
            sign_in(user)
        end
        context "when user is signed in" do
            it "creates appointment on post" do
            post :create, params: { appointment: { date: "2023-04-20 00:00:00"} ,account_id:account.id,user_id:user.id}
            expect(Appointment.exists?(appointment1.id)).to be true
            end
        end
    

        context "with invalid params" do
            it "does not create appointment" do
            expect {
                post :create, params: { appointment: { date: "" }, account_id:account.id ,user_id:user.id }
            }.not_to change(Account, :count)
            end
        end
    end

    describe "PUT #update" do
        before(:each) do
            sign_in(user)
        end 
        context "with valid params" do
            it "updates the appointment" do
            put :update, params: { id: appointment1.id, appointment: { date: "2023-05-29 00:00:00" }, account_id: account.id, user_id: user.id }
            appointment1.reload
            expect(appointment1.date).to eq "2023-05-29 00:00:00" 
            end
        end
    end 


    describe "DELETE #destroy" do
    before(:each) do
    sign_in(user)
    end 
    it "destroys the appointment" do
    delete :destroy, params: { id: appointment1.id, account_id: account.id, user_id: user.id }
    expect(Appointment.exists?(appointment1.id)).to be false
    end
end

describe "set_appointment" do
    before(:each) do
      sign_in(user)
    end 
  
    context "when appointment does not exist" do
      it "redirects to index page" do
        get :edit, params: { id: 0, account_id: account.id, user_id: user.id }
        expect(response).to redirect_to appointments_path
      end
    end
  end

end        