class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :food_id, presence: true
  validates :quantity, presence: true, numericality: { decimal: true, greater_than: 0 }
end
