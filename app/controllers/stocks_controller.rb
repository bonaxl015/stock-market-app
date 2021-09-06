class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_stock, only: %i[edit update destroy]
  include StocksHelper

  def index
    @user_stocks = Stock.where(user_id: current_user.id)
  end

  def new
    @stock = current_user.stocks.build
  end

  def create
    @stock = current_user.stocks.build(stock_params)

    begin
      @stock_name = Stock.iex_api.quote(retrieve_symbol).company_name
      @stock_price = Stock.iex_api.quote(retrieve_symbol).latest_price
      @stock.update(name: @stock_name, unit_price: @stock_price)
    rescue StandardError
      nil
    end

    respond_to do |format|
      if @stock.save
        keep_symbol('')
        format.html { redirect_to stocks_market_path, notice: 'Stock was successfully added.' }
        format.json { render :index, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to stocks_market_path, notice: 'Stock was successfully updated.' }
        format.json { render :index, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_market_path, notice: 'Stock was successfully deleted.' }
    end
  end

  def market
    @stocks = Stock.all.order(:name)
  end

  def search
    respond_to do |format|
      if params[:symbol]
        @stock_search = Stock.lookup(params[:symbol])
        if @stock_search
          keep_symbol(params[:symbol])
          format.html { redirect_to new_stock_path(@stock_search) }
        else
          format.html { redirect_to new_stock_path, notice: 'Please enter a valid stock symbol' }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def top_up; end

  def add_money
    respond_to do |format|
      if process_top_up(params[:money])
        format.html { redirect_to stocks_market_path, notice: 'Topped up successfully' }
        format.json { head :no_content }
      else
        format.html { render :top_up, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:name, :unit_price, :shares)
  end
end
