require 'rails_helper'

RSpec.describe 'Stocks', type: :request do
  subject(:stock) { create(:stock) }

  let(:valid_attributes) { attr_strat(:stock) }
  let(:invalid_attributes) { attr_strat(:stock, :invalid_attributes) }

  shared_examples 'renders a successful response' do
    it 'renders a successful response' do
      expect(response).to be_successful
    end
  end

  shared_examples 'renders 422 response' do
    it 'renders 422 response' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'when user signed in' do
    shared_examples 'redirects to the stocks market' do
      it 'redirects to the stocks market' do
        expect(response).to redirect_to(stocks_market_url)
      end
    end

    before do
      sign_in create(:user, user_type: 'Broker')
    end

    describe 'GET /index' do
      before do
        get stocks_url
      end

      include_examples 'renders a successful response'
    end

    describe 'GET /show' do
      it 'raises error' do
        expect do
          get stock_url(stock)
        end.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'GET /new' do
      before do
        get new_stock_url
      end

      include_examples 'renders a successful response'
    end

    describe 'GET /edit' do
      before do
        get edit_stock_url(stock)
      end

      include_examples 'renders a successful response'
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        before do
          post stocks_url, params: { stock: valid_attributes }
        end

        include_examples 'redirects to the stocks market'
      end

      context 'with invalid parameters' do
        before do
          post stocks_url, params: { stock: invalid_attributes }
        end

        include_examples 'renders 422 response'
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { attr_strat(:stock, :new_attributes) }

        before do
          patch stock_url(stock), params: { stock: new_attributes }
        end

        include_examples 'redirects to the stocks market'
      end

      context 'with invalid parameters' do
        before do
          patch stock_url(stock), params: { stock: invalid_attributes }
        end

        include_examples 'renders a successful response'
      end
    end

    describe 'DELETE /destroy' do
      before do
        delete stock_url(stock)
      end

      include_examples 'redirects to the stocks market'
    end
  end

  context 'when user not signed in' do
    shared_examples 'redirects to log in' do
      it 'redirects to log in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /index' do
      before do
        get stocks_url
      end

      include_examples 'redirects to log in'
    end

    describe 'GET /show' do
      it 'raises error' do
        expect do
          get stock_url(stock)
        end.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'GET /new' do
      before do
        get new_stock_url
      end

      include_examples 'redirects to log in'
    end

    describe 'GET /edit' do
      before do
        get edit_stock_url(stock)
      end

      include_examples 'redirects to log in'
    end
  end
end
