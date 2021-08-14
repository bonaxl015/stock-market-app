require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.create(email: 'example@mail.com',
                           password: 'password',
                           username: 'Username01',
                           user_type: 'Broker')
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(subject).to be_valid
    end
  end

  context 'without a username' do
    before do
      subject.username = nil
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when username is not unique' do
    before do
      User.create(email: 'example2@mail.com',
                  password: 'password2',
                  username: 'Username01',
                  user_type: 'Buyer')
    end

    it 'does not validate' do
      subject.username = subject.username
      expect(subject).to_not be_valid
    end

    context 'when not case sensitive' do
      it 'does not validate' do
        subject.username = subject.username.downcase
        expect(subject).to_not be_valid
      end
    end
  end

  context 'when username is less than 6 characters' do
    before do
      subject.username = 'A' * 5
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end

  context 'when username contains special characters' do
    before do
      subject.username = 'Username.01'
    end

    it 'does not validate' do
      expect(subject).to_not be_valid
    end
  end
end
