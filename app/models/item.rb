class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  belongs_to :category
  belongs_to :prefecture
  belongs_to :condition
  belongs_to :shippingcost
  belongs_to :postage

  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :itemname
    validates :description
    validates :category_id
    validates :condition_id
    validates :shippingcost_id
    validates :prefecture_id
    validates :postage_id
    validates :price
  end
  with_options numericality: { only_integer: true } do
    validates :category_id, :condition_id, :postage_id, :prefecture_id, :shippingcost_id,  numericality: { other_than: 1 , message: "can't be blank"} 
  
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
end