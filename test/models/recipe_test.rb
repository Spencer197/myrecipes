require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",#This line creates a chef for testing purposes.
                        password: "password", password_confirmation: "password")#This line creates a password for the chef.
    @recipe = @chef.recipes.build(name: "Vegetable Soup", description: "Great Vegetable Soup!")#Replaces line below to assign a chef to a new recipe. The build method automtically adds the chef id to the recipe.
    #@recipe = Recipe.new(name: "Vegetable Soup", description: "Great Vegetable Soup!")#Simply creates a new recipe.
  end
  
  test "recipe without chef id should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "Description shouldn't be less than 5 characters." do
    @recipe.description = "a" * 4
    assert_not @recipe.valid?
  end

  test "Description shouldn't be more than 10000 characters." do
    @recipe.description = "a" * 10001
    assert_not @recipe.valid?
  end
end