class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id]) 
    unless user_signed_in? && current_user.id == @item.user_id
      redirect_to root_path
    end
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id]) 
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :itemname, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shippingcost_id, :price).merge(user_id: current_user.id)
  end

  def redirectove_to_index
    redirect_to root_path unless @item.user_id == current_user.id
  end

end

