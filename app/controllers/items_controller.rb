class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]


  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :itemname, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shippingcost_id, :price).merge(user_id: current_user.id)
  end
end