require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Beef Ma-po Tofu", description: "Thinly sliced beef cooked with tofu and vegetables", chef: @chef)
  end
  
  test "successfully delete a recipe" do
    get recipe_path(@recipe)#Go to show recipes page.
    assert_template 'recipes/show'#Check that show page is displayed.
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"#Checks that 'Delete' button appears in show recipes page.
    assert_difference 'Recipe.count', -1 do#Checks that the recipe count in database is reduced by 1.
      delete recipe_path(@recipe)#Checks that delete action is requested for recipe_path @recipe.  
  end
  assert_redirected_to recipes_path#Go to recipes listing (index).
  assert_not flash.empty?#Checks that the flash message is not empty and appears.
  end
end
