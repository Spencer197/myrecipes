class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  belongs_to :chef#Aserts that recipes belong to the Chef class.
  validates :chef_id, presence: true#Explicitly asserts that chef_id must be present at all times when creating a recipe.  Therefore, in recipe_test.rb, when the first test assigns nil to chef_id, the test fails.
end
