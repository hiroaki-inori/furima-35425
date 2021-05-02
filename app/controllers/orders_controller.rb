class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :login_myitem, only: [:index]
  before_action :sold_item, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    item = Item.find(params[:item_id])
    params.require(:order_delivery).permit(:postcode, :prefecture_id, :city, :block, :building, :tel).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token], price: item.price
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def login_myitem
    item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == item.user.id
  end

  def sold_item
    item = Item.find(params[:item_id])
    redirect_to root_path unless item.order.nil?
  end
end
