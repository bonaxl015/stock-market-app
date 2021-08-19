require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /registrations' do
    context 'with valid parameters' do
      before do
        post '/users', params: { user: attr_strat(:user) }
      end

      it 'redirects to stocks market' do
        expect(response).to redirect_to(stocks_market_path)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/users', params: { user: attr_strat(:user, :invalid_attributes) }
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end
    end
  end
end
