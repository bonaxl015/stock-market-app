require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:mail) { described_class.success_notification(user).deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq('Stock Market App Registration Successful!')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['from@example.com'])
  end

  it 'assigns @username' do
    expect(mail.body.encoded).to match(user.username)
  end
end
