RSpec.describe "GET /api/v1/comments", type: :request do

    describe "GET /api/v1/comments" do

      context "when comments exist" do
    #   let!(:count) {Appointment.count}
      let!(:user){create(:user)}
      let!(:account) { create(:account) }
      let!(:property) { create(:property, account: account)}
      let!(:comment) {create(:comment, commentable: account, user: user)}

      before(:each) do
        get "/api/v1/comments"
      end
      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
       
      it "returns a JSON response with all messages" do

        expect(response).to have_http_status(:success)
        change{JSON.parse(response.body).size}.by(1)
      
      end
    end
    end

    describe "POST /api/v1/comments" do
        let!(:user) { create(:user) }
        let!(:account) { create(:account) }
        let!(:property) { create(:property, account: account) }
        let!(:valid_params) { { comment: { content: "Test comment", user_id: user.id, commentable_type: "Account", commentable_id: account.id } } }
    
        before(:each) do
          post "/api/v1/comments", params: valid_params
        end
    
        it "returns a successful response" do
          expect(response).to have_http_status(:created)
        end
    
        it "creates a new comment" do
          expect {
            post "/api/v1/comments", params: valid_params
          }.to change(Comment, :count).by(1)
        end
    end

    describe "PUT /api/v1/comments/:id" do
        context "when the comment exists" do
          let!(:user) { create(:user) }
          let!(:account) { create(:account) }
          let!(:property) { create(:property, account: account) }
          let!(:comment) { create(:comment, commentable: account, user: user) }
          let(:new_content) { "Updated test comment" }
          let(:valid_params) { { comment: { content: new_content } } }
    
          before(:each) do
            put "/api/v1/comments/#{comment.id}", params: valid_params
          end
    
          it "returns a successful response" do
            expect(response).to have_http_status(:ok)
          end
    
          it "updates the comment with new content" do
            comment.reload
            expect(comment.content).to eq("updated test comment")
          end
        end
    
        context "when the comment does not exist" do
          let(:nonexistent_id) { 123456 }
    
          before(:each) do
            put "/api/v1/comments/#{nonexistent_id}"
          end
    
          it "returns a not found response" do
            expect(response).to have_http_status(:not_found)
          end
        end
    end 

    describe "DELETE /api/v1/comments/:id", type: :request do
        let!(:user) { create(:user) }
        let!(:account) { create(:account) }
        let!(:comment) { create(:comment, commentable: account, user: user) }
        
        before(:each) do
        delete "/api/v1/comments/#{comment.id}"
        end
        
        it "returns a successful response" do
        expect(response).to have_http_status(:no_content)
        end
        
        
        
        it "returns a not found response when the comment does not exist" do
        delete "/api/v1/comments/999"
        expect(response).to have_http_status(:not_found)
        end
    end    

end 