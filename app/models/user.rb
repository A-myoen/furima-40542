class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  
  
  attribute :birthdate, :date
  validates :nickname, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :firstname
    validates :lastname
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ , message: '全角カタカナを使用してください' } do
    validates :firstnamekana
    validates :lastnamekana
  end

  validates :birthdate, presence:true

  validates_format_of :password, with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "must include both letters and numbers"

end
