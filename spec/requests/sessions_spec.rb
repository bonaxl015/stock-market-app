require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  shared_examples 'renders a successful response' do
    it 'renders a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'POST /sessions' do
    context 'with valid parameters' do
      before do
        post user_session_path, params: { user: attr_strat(:user) }
      end

      include_examples 'renders a successful response'
    end

    context 'with invalid parameters' do
      before do
        post user_session_path, params: { user: attr_strat(:user, :invalid_attributes) }
      end

      include_examples 'renders a successful response'
    end
  end
end
