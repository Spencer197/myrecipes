require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com",
                        password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "John", email: "john@example.com",
                         password: "password", password_confirmation: "password")
  end
  
  test "should get chefs listings" do
      get chefs_path
      assert_template 'chefs/index'#Checks that the chefs index template is present.
      assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.titleize#Checks that the link for @chef is present.
      assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.titleize#Checks that the link for @chef2 is present.
  end
  
  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)#Deletes a test chef 'chef2' 
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end