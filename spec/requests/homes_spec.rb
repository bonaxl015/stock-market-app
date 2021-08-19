require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /index' do
    before do
      get home_index_path
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'raises an error' do
      expect do
        get '/home/1'
      end.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'GET /new' do
    it 'raises an error' do
      expect do
        get '/home/new'
      end.to raise_error(ActionController::RoutingError)
    end
  end
end
