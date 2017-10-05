require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
    def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
    end
  
  test "reject an invalid edit" do
    get edit_chef_path(@chef)
      patch chef_path(@chef), params: { chef: { chefname: " ", email: "spencer@example.com" } }
    assert_template 'chefs/edit'#Shows signup form again
    assert_select 'h2.panel-title'#Calls error messages partial
    assert_select 'div.panel-body'#Call the panel html for error messages
  end
  
  test "accept a vaild edit" do
    get edit_chef_path(@chef)
      patch chef_path(@chef), params: { chef: { chefname: "Spencer1", email: "spencer1@example.com" } }
    assert_redirected_to @chef#Redirects to the chef's show page
    assert_not flash.empty?
    @chef.reload#Reloads the chef's params for edit to take effect.
    assert_match "Spencer1", @chef.chefname
    assert_match "spencer1@example.com", @chef.email
  end
end
