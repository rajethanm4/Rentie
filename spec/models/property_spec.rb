require 'rails_helper'

RSpec.describe Property, type: :model do
  context 'when creating a account' do
    let(:account) { build :account}
    let(:property) { build :property,account:account}
    let(:property1) { build :property,account:account,name: nil}
    let(:property2) { build :property,account:account,address: nil}
    let(:property3) { build :property,account:account,price: nil}
    it 'should be valid account with all attributes' do
      expect(property.valid?).to eq (true)  
    end

    it 'should be valid account with all attributes' do
      expect(property1.valid?).to eq (false)  
    end

    it 'should be valid account with all attributes' do
      expect(property2.valid?).to eq (false)  
    end

    it 'should be valid account with all attributes' do
      expect(property3.valid?).to eq (false)  
    end

   end
end
