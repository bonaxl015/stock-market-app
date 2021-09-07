class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_stock, except: %i[all]
  include OrdersHelper

  def new
    @stock_limit = (current_user.money / @stock.unit_price).floor
    @order = @stock.orders.build
  end

  def create
    @order = @stock.orders.build(order_params.merge(user_id: current_user.id))
    @order.update(name: @stock.name, unit_price: @stock.unit_price)

    respond_to do |format|
      if @order.save
        process_buy_stock(current_user.id, @order.shares, @stock.id)
        format.html { redirect_to orders_all_path, notice: 'Stock was successfully ordered.' }
        format.json { render :all, status: :created, location: @order.stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @order = @stock.orders.find(params[:id])
  end

  def update
    @order = @stock.orders.find(params[:id])
    @current_shares = @order.shares
    respond_to do |format|
      if @order.update(order_params)
        process_sell_stock(@stock.id, current_user.id, @order.id, @current_shares)
        format.html { redirect_to orders_all_path, notice: 'Stock was successfully sold.' }
        format.json { render :all, status: :created, location: @order.stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def all
    @user_orders = Order.where(user_id: current_user.id).order(:name)
    @total_invested = calculate_investments(@user_orders)
  end

  private

  def find_stock
    @stock = Stock.find(params[:stock_id])
  end

  def order_params
    params.require(:order).permit(:name, :unit_price, :shares)
  end
end
