require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Beef Ma-po Tofu", description: "Thinly sliced beef cooked with tofu and vegetables", chef: @chef)
  end
  
  test "reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)#Goes to edit recipe path and uses dynamic ID number to find recipe to be edited.
    assert_template 'recipes/edit'#Asserts/displays the recipes edit form template/view.
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description" }}# Attempts to update an invalid recipe, but gets rejected. 
    assert_template 'recipes/edit'# Returns user to the recipes edit template.
    assert_select 'h1.panel-title'#Shows an error message.
    assert_select 'div.panel-body'#Lists the errors.
  end
  
  test "successfully edit a recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to @recipe#Explicitly assert the edited recipe's show page.  @recipe means the recipe show page. 
    #follow redirect! #This is how we redirected to the recipe's show page for the create action
    assert_not flash.empty?#Checks that the flash message is not empty.
    @recipe.reload#Reloads to edited version of the recipe.
    assert_match updated_name, @recipe.name#These assert_match lines show an alternative to the 'response.body' assert_match in recipes_test. 
    assert_match updated_description, @recipe.description
  end
end
