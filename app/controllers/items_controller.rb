class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :find_item, only: [:show, :edit, :update, :destroy ]
  before_action :redirectove_to_index, only: [:edit, :update, :destroy ]

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
  end

  def edit
    if current_user.id != @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :itemname, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shippingcost_id, :price).merge(user_id: current_user.id)
  end

  def redirectove_to_index
    redirect_to root_path unless @item.user_id == current_user.id
  end

  def find_item
    @item = Item.find(params[:id])
  end

end

