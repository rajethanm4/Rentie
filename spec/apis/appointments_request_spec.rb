RSpec.describe "GET /api/v1/appointments", type: :request do

    describe "GET /api/v1/appointments" do

      context "when appointments exist" do
    #   let!(:count) {Appointment.count}
      let!(:user){create(:user)}
      let!(:account) { create(:account) }
      let!(:appointment) { create(:appointment, account: account ,user:user) }

      before(:each) do
        get "/api/v1/appointments"
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


    describe "POST /api/v1/appointments" do
        let!(:user){create(:user)}
        let!(:account) { create(:account) }
        let!(:valid_params) { { appointment: { account_id: account.id, user_id: user.id, date: Date.tomorrow } } }
        
        before(:each) do
          post "/api/v1/appointments", params: valid_params
        end
        
        it "returns a successful response" do
          expect(response).to have_http_status(:created)
        end
        
        it "creates a new appointment" do
          expect {
            post "/api/v1/appointments", params: valid_params
          }.to change(Appointment, :count).by(1)
        end
    end

    describe "PUT /api/v1/appointments/:id" do
        let!(:user) { create(:user) }
        let!(:account) { create(:account) }
        let!(:appointment) { create(:appointment, account: account, user: user) }
        let(:new_date) { Date.tomorrow }
        let(:valid_params) { { appointment: { date: new_date } } }
    
        before(:each) do
          put "/api/v1/appointments/#{appointment.id}", params: valid_params
        end
    
        it "returns a successful response" do
          expect(response).to have_http_status(:ok)
        end
    
        it "updates the appointment with new date" do
          appointment.reload
          expect(appointment.date).to eq(new_date)
        end
    end

    describe "DELETE /api/v1/appointments/:id" do
        let!(:user) { create(:user) }
        let!(:account) { create(:account) }
        let!(:appointment) { create(:appointment, account: account, user: user) }
        before(:each) do
            delete "/api/v1/appointments/#{appointment.id}"
          end
          
          it "returns a successful response" do
            expect(response).to have_http_status(:no_content)
          end
          
          it "deletes the appointment" do
            expect(Appointment.exists?(appointment.id)).to be_falsey
        end
    end    

end