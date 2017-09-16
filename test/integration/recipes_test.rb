require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com")
    @recipe = Recipe.create(name: "Beef Ma-po Tofu", description: "Thinly sliced beef cooked with tofu and vegetables", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Saute", description: "Chicken cooked on a stick")
    @recipe2.save 
  end
  
  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes index listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body#Asserts that the recipe name should appear in the body on the page.
    assert_match @recipe2.name, response.body
  end
end
