require 'rails_helper'

RSpec.describe "GET /api/v1/users", type: :request do

    describe "GET /api/v1/users" do
      context "when users exist" do
        let!(:user1) { create(:user) }
        let!(:user2) { create(:user) }
  
        it "returns a list of users" do
          get "/api/v1/users"
          expect(response).to have_http_status(200)
          expect(response.content_type).to match(/^application\/json/)
        end
      end
  
      context "when no users exist" do
        it "returns an empty list" do
          get "/api/v1/users"
          expect(response).to have_http_status(200)
        end
      end
    end
end