require 'rails_helper'

RSpec.describe User, type: :model do
 context 'when creating a user' do
  let(:user) { create :user}
  let(:user1) { build :user, first_name: nil }
  let(:user2) { build :user, last_name: nil }
  let(:user3) { build :user, email: "email" }
  it 'should be valid user with all attributes' do
    expect(user.valid?).to eq(true)  
  end
 
  it 'should have valid first name' do
    expect(user1.valid?).to eq(false)
   end  


  it 'should have valid last name' do
    expect(user2.valid?).to eq(false)
   end  


  it 'should have valid email' do
    expect(user3.valid?).to eq(false)
   end  

   it 'should normalize first and last name before saving' do
    user.first_name = 'RAJ'
    user.last_name = 'VARDHAN'
    user.save

    expect(user.first_name).to eq('Raj')
    expect(user.last_name).to eq('Vardhan')
  end
  
 end
end
