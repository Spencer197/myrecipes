require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Beef Ma-po Tofu", description: "Thinly sliced beef cooked with tofu and vegetables", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Saute", description: "Chicken cooked on a stick")
    @recipe2.save 
  end
  
  test "should get chefs show page" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name#Asserts that the recipe name link should appear in the body on the page.
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name#Asserts that the recipe2 name link should appear in the body on the page.
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
end
