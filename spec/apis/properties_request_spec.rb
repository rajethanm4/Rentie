require 'rails_helper'

RSpec.describe "GET /api/v1/properties", type: :request do
  
    #for all Properties
    describe "GET /api/v1/properties" do
  
      context "when properties exist" do
        let!(:count) {Property.count}
        let!(:account) { create(:account) }
        let!(:properties) { create_list(:property, 3, account: account) }
        
        before(:each)do
          get "/api/v1/properties"
        end
         
        it "returns a successful response" do
            expect(response).to have_http_status(200)
        end

        it "returns a JSON response with all properties" do
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body)).to have_key("properties")
            expect(JSON.parse(response.body)["properties"].size).to eq(count + 3)
        end

      end

      context "when no properties exist" do

        before(:each) do
          Property.destroy_all
          get "/api/v1/properties"
        end
  
        it "returns an empty JSON response" do
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)["properties"]).to eq([])    
        end
  
      end
    end

    describe "Propety create" do
        let(:account) { create(:account) }
        let(:property){create(:property, account:account)}
        context "with valid attributes" do
          
          it "creates a new seller" do
            expect {
              post '/api/v1/properties',params: { property: { name: "incubspace18", address: "chennai", price: 10000, rooms: 5, account_id: account.id} }
    
            }.to change(Property, :count).by(1)
          end

          it "returns a successful response" do
            post "/api/v1/properties", params: { property: { name: "incubspace18", address: "chennai", price: 10000, rooms: 5, account_id: account.id} }
            expect(response).to have_http_status(:created)
          end
          
          it "returns the created message in the response" do
            post "/api/v1/properties", params: { property: { name: "incubspace18", address: "chennai", price: 10000, rooms: 5, account_id: account.id} }
            expect(JSON.parse(response.body)["name"]).to eq("incubspace18")
            expect(JSON.parse(response.body)["address"]).to eq("chennai")
          end
        end

        context "with invalid attributes" do
            let(:invalid_attributes) { { property: { name: nil, address: nil, price: nil, room: nil } } }
        
            it "does not create a new property" do
              expect {
                post "/api/v1/properties", params: invalid_attributes
              }.to_not change(Property, :count)
            end

            it "returns an error message in the response" do
                post "/api/v1/properties", params: invalid_attributes
                expect(JSON.parse(response.body)["error"]).to_not be_empty
            end
          
            it "returns a 422 unprocessable entity status code" do
                post "/api/v1/properties", params: invalid_attributes
                expect(response).to have_http_status(:unprocessable_entity)
            end
            
        end    
    end

#rspec for property comments count.
describe '#property_comments' do
 let(:user) { create(:user) }
 let(:account) { create(:account) }
 let(:property) { create(:property, account: account)}
 let(:comment) {create(:comment, commentable: account, user: user)}
  context 'when property exists' do
    before { 
      get "/api/v1/properties/property_comments", params: { id: property.id } 
      
    }
    
    it 'returns the number of comments on the property' do
      expect(JSON.parse(response.body)) == property.comments.count
    end
  end 
end



end    