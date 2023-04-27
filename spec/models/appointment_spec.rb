require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context 'when creating a appointment' do
  let(:account) {build :account}
  let(:user) { build(:user) }
  let(:appointment) {build(:appointment,account: account, user: user)}
  it 'should be valid  with all attributes' do
    expect(appointment.valid?).to eq (true)  
  end

  # validation
  it 'should set default date if date is nil' do
    appointment.date = nil
    appointment.save

    expect(appointment.date).to eq(Date.today)
  end
  
  it 'should not set default date if date is present' do
    appointment.date = Date.tomorrow
  appointment.save

  expect(appointment.date).to eq(Date.tomorrow)
  end
end

context 'when validating an appointment' do
  let(:account) { build :account }
  let(:user) { build(:user) }
  let(:appointment) { build(:appointment, account: account, user: user) }

  # callback
  
  it 'should not allow date to be in the past' do
    appointment.date = Date.yesterday
    expect(appointment.valid?).to eq(false)
    expect(appointment.errors[:date]).to include("can't be in the past")
  end
end

end
