require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'when creating a account' do
    let(:account) { build :account}
    let(:account1) { build :account, first_name: nil }
    let(:account2) { build :account, last_name: nil }
    let(:account3) { build :account, email: "email" }

    it 'should be valid account with all attributes' do
      expect(account.valid?).to eq (true)  
    end

    it 'should have valid first name' do
      expect(account1.valid?).to eq(false)
     end  
  
  
    it 'should have valid last name' do
      expect(account2.valid?).to eq(false)
     end  
  
  
    it 'should have valid email' do
      expect(account3.valid?).to eq(false)
     end  
  
     it 'should normalize first and last name before saving' do
      account.first_name = 'RAHUL'
      account.last_name = 'KUMAR'
      account.save
  
      expect(account.first_name).to eq('Rahul')
      expect(account.last_name).to eq('Kumar')
    end

   end
end
