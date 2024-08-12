class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :street, :building, :phone, :token
  
  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'input correctly' }
    validates :phone, format: { with: /\A\d{10,11}\z/, message: 'input only number' }
    validates :prefecture_id,  numericality: { other_than: 1 , message: "can't be blank"} 
    validates :city, :street, :user_id, :item_id, :token
  end


  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShoppingAdress.create(
        postcode: postcode,
        prefecture_id: prefecture_id,
        city: city,
        street: street,
        building: building,
        phone: phone,
        order_id: order.id
        )
  end

end