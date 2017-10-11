require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
    def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "John", email: "john@example.com",
                         password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "John1", email: "john1@example.com",
                         password: "password", password_confirmation: "password", admin: true)
    end
  
  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
      patch chef_path(@chef), params: { chef: { chefname: " ", email: "spencer@example.com" } }
    assert_template 'chefs/edit'#Shows signup form again
    assert_select 'h2.panel-title'#Calls error messages partial
    assert_select 'div.panel-body'#Call the panel html for error messages
  end
  
  test "accept a vaild edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
      patch chef_path(@chef), params: { chef: { chefname: "Spencer1", email: "spencer1@example.com" } }
    assert_redirected_to @chef#Redirects to the chef's show page
    assert_not flash.empty?
    @chef.reload#Reloads the chef's params for edit to take effect.
    assert_match "Spencer1", @chef.chefname
    assert_match "spencer1@example.com", @chef.email
  end
  
  test "accept edit atempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
      patch chef_path(@chef), params: { chef: { chefname: "Spencer2", email: "spencer2@example.com" } }
    assert_redirected_to @chef#Redirects to the chef's show page
    assert_not flash.empty?
    @chef.reload#Reloads the chef's params for edit to take effect.
    assert_match "Spencer2", @chef.chefname
    assert_match "spencer2@example.com", @chef.email
  end
  
  test "redirect edit attempt by non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name "joe"#Simulates an attempted edit of Spencer's account by non-admin user.
    updated_email "joe@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to @chef#Redirects to the chef's show page
    assert_not flash.empty?
    @chef.reload#Reloads the chef's params for edit to take effect.
    assert_match "Spencer", @chef.chefname
    assert_match "spencer@example.com", @chef.email
  end
end
