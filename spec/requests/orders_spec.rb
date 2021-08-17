require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  subject(:order) { create(:order, stock_id: stock.id) }

  let(:stock) { create(:stock) }
  let(:valid_attributes) { attr_strat(:order) }
  let(:invalid_attributes) { attr_strat(:order, :invalid_attributes) }

  shared_context 'when user signed in' do
    before do
      sign_in create(:user, user_type: 'Buyer')
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

  describe 'GET /index' do
    include_context 'when user signed in'

    it 'raises an error' do
      expect do
        get stock_orders_url(stock)
      end.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'GET /all' do
    include_context 'when user signed in'

    before do
      get orders_all_url
    end

    include_examples 'renders a successful response'
  end

  describe 'GET /show' do
    include_context 'when user signed in'

    it 'raises an error' do
      expect do
        get stock_order_url(stock, order)
      end.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'GET /new' do
    include_context 'when user signed in'

    before do
      get new_stock_order_url(stock)
    end
  end

  describe 'POST /create' do
    include_context 'when user signed in'

    context 'with valid parameters' do
      before do
        post stock_orders_url(stock), params: { order: valid_attributes }
      end

      it 'redirects to all orders' do
        expect(response).to redirect_to(orders_all_url)
      end
    end

    context 'with invalid parameters' do
      before do
        post stock_orders_url(stock), params: { order: invalid_attributes }
      end

      include_examples 'renders unprocessable entity response'
    end
  end

  describe 'PATCH /update' do
    include_context 'when user signed in'

    context 'with valid parameters' do
      let(:new_attributes) { attr_strat(:order, :new_attributes) }

      before do
        patch stock_order_url(stock, order), params: { order: new_attributes }
      end

      it 'redirects to all orders' do
        expect(response).to redirect_to(orders_all_path)
      end
    end

    context 'with invalid parameters' do
      before do
        patch stock_order_url(stock, order), params: { order: invalid_attributes }
      end

      include_examples 'renders unprocessable entity response'
    end
  end

  describe 'DELETE /destroy' do
    include_context 'when user signed in'

    it 'raises an error' do
      expect do
        delete stock_order_url(stock, order)
      end.to raise_error(ActionController::RoutingError)
    end
  end

  context 'when user not signed in' do
    shared_examples 'redirects to log in' do
      it 'redirects to log in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET /index' do
      it 'raises an error' do
        expect do
          get stock_orders_url(stock)
        end.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'GET /show' do
      it 'raises an error' do
        expect do
          get stock_order_url(stock, order)
        end.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'GET /new' do
      before do
        get new_stock_order_url(stock)
      end

      include_examples 'redirects to log in'
    end

    describe 'GET /edit' do
      before do
        get edit_stock_order_url(stock, order)
      end

      include_examples 'redirects to log in'
    end
  end
end
