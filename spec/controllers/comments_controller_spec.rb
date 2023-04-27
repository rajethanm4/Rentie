require 'rails_helper'
RSpec.describe CommentsController, type: :controller do
    let!(:user) { create(:user) }
    let!(:account) { create(:account) }
    let!(:property) { create(:property, account: account)}
    let(:comment1) {create(:comment, commentable: account, user: user)}

end