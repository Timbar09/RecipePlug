class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, foreign_key: :owner_id, dependent: :destroy
  has_many :foods, foreign_key: :owner_id, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end
