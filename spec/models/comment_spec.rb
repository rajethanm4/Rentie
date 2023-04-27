require 'rails_helper'

RSpec.describe 'Comments', type: :model do
  let(:user) { create(:user) }
  let(:account) { create(:account)}
  let!(:property) { create(:property, account: account)}
  let(:comment) {create(:comment, commentable: account, user: user)}
  it 'should be valid  with all attributes' do
    expect(comment.valid?).to eq (true)  
  end
  
  it 'should be invalid without a user' do
    comment.user = nil
    expect(comment.valid?).to eq(false)
  end

  it 'should be invalid without a commentable' do
    comment.commentable = nil
    expect(comment.valid?).to eq(false)
  end

  it 'should be valid with all required attributes' do
    comment.content = 'This is a test comment'
    expect(comment.valid?).to eq(true)
  end

  it 'should convert body to lowercase before saving' do
    comment.content = 'HELLO WORLD'
    comment.save
    expect(comment.reload.content).to eq('hello world')
  end
end
