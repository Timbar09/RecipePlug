class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes, through: :food_recipes

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :measurement_unit, presence: true, length: { maximum: 20 }
  validates :price, presence: true, numericality: { decimal: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { decimal: true, greater_than: 0 }
end
