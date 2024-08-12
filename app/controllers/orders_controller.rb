class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:index, :create]

  def index
    if current_user.id != @item.user_id && @item.order == nil
    @order_form = OrderForm.new
    else
      redirect_to root_path
    end
  end

  def create
    @order_form = OrderForm.new(order_params)
    if  @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  
  private

  def find_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_form).permit(:postcode, :prefecture_id, :city, :street, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = 'pk_test_acfa30671855b11e318d0a0a'
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  rescue Payjp::InvalidRequestError => e
    # エラーハンドリング
    Rails.logger.error "Payjp::InvalidRequestError: #{e.message}"
  end
end