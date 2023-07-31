class RecipeFood < ApplicationRecord
  belongs_to :recipe, dependent: :destroy
  belongs_to :food, dependent: :destroy

  validates :quantity, presence: true, numericality: { decimal: true, greater_than: 0 }
end
