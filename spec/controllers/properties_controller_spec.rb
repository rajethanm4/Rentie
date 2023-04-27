require 'rails_helper'

RSpec.describe PropertiesController do

    let!(:count){Property.all.count}
    let(:account){ create(:account)}
    let!(:property1) { create(:property, account: account)}
    

    #rspec for get index
    describe "GET #index" do
        it "assigns properties to property" do
            get :index
            expect((Property).all.count).to eq(count+1)
        end
   end

   describe "GET #show" do
      it "assigns the requested message to @message" do
        get :show, params: { id: property1.id }
        expect(assigns(:property)).to eq(property1)
      end
    end  

    describe "POST #create" do 
        before(:each) do
            sign_in(account)
        end
        context "when account is signed in" do
        it "should creates a property" do
        post :create, params: { property: { name: "incubspace18", address: "chennai", price: 10000, rooms: 5} ,account_id:account.id}
        expect(Property.exists?(property1.id)).to be true

        end
      end
      #rspec invalid - params
      context "with invalid params" do
        it "should not create a new property" do
          expect {
            post :create, params: { property: { name: "", address: "", price: "", rooms: "" }, account_id:account.id}
          }.not_to change(Property, :count)
        end
      
      end
    end 
    
    #rspec for destroy action
    describe "DELETE #destroy" do
        before(:each) do
            sign_in(account)
        end 
        it "destroys the post" do
            delete :destroy, params: { id: property1.id, property: { name: "absyz", address: "hyderabad", price: 10000, rooms: 4 },account_id: account.id}
            expect(Property.exists?(property1.id)).to be false
        end
    end

    #rspec for update action for message
    describe "PUT #update" do
        before(:each) do
            sign_in(account)
        end 
        context "with valid params" do
            it "updates the message" do
            put :update, params: { id: property1.id, property: { name: "Update" }, account_id: account.id}
            property1.reload
            expect(property1.name).to eq "Update" 
            end
        end

        context "with invalid params" do
          it "does not update the message" do
          put :update, params: { id: property1.id, property: { name: "" }, account_id: account.id }
          property1.reload
          expect(property1.name).not_to eq ""
          end
        end
    end

    
    
end   