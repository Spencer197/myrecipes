require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
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
    #assert_match @recipe.name, response.body - replaced by line below.
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name#Asserts that the recipe name link should appear in the body on the page.
    #assert_match @recipe2.name, response.body - replaced by line below.
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name#Asserts that the recipe2 name link should appear in the body on the page.
  end
  
  test "should get recipes show page" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body#Checks for recipe name in the body of show page.
    assert_match @recipe.description, response.body#Checks for description
    assert_match @chef.chefname, response.body#Checks for chefname.
    assert_match 'a[href=?]', edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
    assert_select 'a[href=?]', recipes_path, text: "Return to recipes listing"
  end
  
  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    description_of_recipe = "Add chicken, add vegetables, fry in oil for 20 minutes"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: {name: name_of_recipe, description: description_of_recipe}} 
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end
  
  
  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ",description: " "} }#If recipe has blank name and description it will be rejected.
    end
    assert_template 'recipes/new'#Returns user to the new recipe view.
    assert_select 'h1.panel-title'#Shows an error message.
    assert_select 'div.panel-body'#Lists the errors.
  end
end
