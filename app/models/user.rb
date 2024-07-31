class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  
  attribute :birthdate, :date
  validates :nickname, presence: true
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :lastnamekana, presence: true
  validates :firstnamekana, presence: true
  validates :birthdate, presence: true
  validates_format_of :password, with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "は英字と数字を含めてください"
  validates :lastnamekana, :firstnamekana, presence: true
  validates_format_of :lastnamekana, :firstnamekana, with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナで入力してください"
end
