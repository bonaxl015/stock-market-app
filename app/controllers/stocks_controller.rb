class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_stocks = Stock.where(user_id: current_user.id)
  end

  def show
    
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def market
    @stocks = Stock.all
  end

  private

  def stock_params
  end
end
