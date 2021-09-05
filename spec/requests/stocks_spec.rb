require 'rails_helper'

RSpec.describe 'Stocks', type: :request do
  subject(:stock) { create(:stock) }

  let(:valid_attributes) { attr_strat(:stock) }
  let(:invalid_attributes) { attr_strat(:stock, :invalid_attributes) }

  let(:stock_search) do
    ENV['IEX_API_PUBLISHABLE_TOKEN'] = 'pk_a770dc46f21640ef9c61535093921ba2'

    client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    { name: client.quote('MSFT').symbol }
  end

  shared_context 'when user signed in' do
    before do
      sign_in create(:user, user_type: 'Broker')
    end
  end

  shared_examples 'renders a successful response' do
    it 'renders a successful response' do
      expect(response).to be_successful
    end
  end

  shared_examples 'renders unprocessable entity response' do
    it 'renders unprocessable entity response' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  shared_examples 'redirects to the stocks market' do
    it 'redirects to the stocks market' do
      expect(response).to redirect_to(stocks_market_path)
    end
  end

  describe 'GET /index' do
    include_context 'when user signed in'

    before do
      get stocks_path
    end

    include_examples 'renders a successful response'
  end

  describe 'GET /market' do
    include_context 'when user signed in'

    before do
      get stocks_market_path
    end

    include_examples 'renders a successful response'
  end

  describe 'GET /top_up' do
    include_context 'when user signed in'

    before do
      get stocks_top_up_path
    end

    include_examples 'renders a successful response'
  end

  describe 'GET /show' do
    include_context 'when user signed in'

    it 'raises error' do
      expect do
        get stock_path(stock)
      end.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'GET /new' do
    include_context 'when user signed in'

    before do
      get new_stock_path
    end

    include_examples 'renders a successful response'
  end

  describe 'GET /edit' do
    include_context 'when user signed in'

    before do
      get edit_stock_path(stock)
    end

    include_examples 'renders a successful response'
  end

  describe 'POST /create' do
    include_context 'when user signed in'

    context 'with valid parameters' do
      before do
        post stocks_path, params: { stock: valid_attributes }
      end

      include_examples 'redirects to the stocks market'
    end

    context 'with invalid parameters' do
      before do
        post stocks_path, params: { stock: invalid_attributes }
      end

      include_examples 'renders unprocessable entity response'
    end
  end

  describe 'POST /add_money' do
    include_context 'when user signed in'

    context 'with valid parameters' do
      before do
        post stocks_add_money_path, params: { money: Faker::Number.number(digits: 5) }
      end

      include_examples 'redirects to the stocks market'
    end

    context 'with invalid parameters' do
      before do
        post stocks_add_money_path, params: { money: nil }
      end

      include_examples 'redirects to the stocks market'
    end
  end

  describe 'POST /search' do
    include_context 'when user signed in'

    context 'with valid parameters' do
      before do
        post stocks_search_path(stock_search), params: { stock: 'MSFT' }
      end

      it 'redirects to the new stock form' do
        expect(response).to redirect_to(new_stock_path(stock_search))
      end
    end

    context 'with invalid parameters' do
      before do
        post stocks_search_path(stock_search), params: { stock: nil }
      end

      include_examples 'renders unprocessable entity response'
    end
  end

  describe 'PATCH /update' do
    include_context 'when user signed in'

    context 'with valid parameters' do
      let(:new_attributes) { attr_strat(:stock, :new_attributes) }

      before do
        patch stock_path(stock), params: { stock: new_attributes }
      end

      include_examples 'redirects to the stocks market'
    end

    context 'with invalid parameters' do
      before do
        patch stock_path(stock), params: { stock: invalid_attributes }
      end

      include_examples 'renders a successful response'
    end
  end

  describe 'DELETE /destroy' do
    include_context 'when user signed in'

    before do
      delete stock_path(stock)
    end

    include_examples 'redirects to the stocks market'
  end

  context 'when user not signed in' do
    shared_examples 'redirects to log in' do
      it 'redirects to log in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /index' do
      before do
        get stocks_path
      end

      include_examples 'redirects to log in'
    end

    describe 'GET /market' do
      before do
        get stocks_market_path
      end

      include_examples 'redirects to log in'
    end

    describe 'GET /top_up' do
      before do
        get stocks_top_up_path
      end

      include_examples 'redirects to log in'
    end

    describe 'GET /show' do
      it 'raises error' do
        expect do
          get stock_path(stock)
        end.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'GET /new' do
      before do
        get new_stock_path
      end

      include_examples 'redirects to log in'
    end

    describe 'GET /edit' do
      before do
        get edit_stock_path(stock)
      end

      include_examples 'redirects to log in'
    end
  end
end
