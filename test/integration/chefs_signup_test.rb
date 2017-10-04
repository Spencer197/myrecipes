require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  
  test "should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "reject an invalid signup" do
    get signup_path
    assert_no_difference "Chef.count" do
      post chefs_path, params: { chef: { chefname: " ", email: " ", password: "password ",
                                password_confirmation: " " } }
    end
    assert_template 'chefs/new'#Shows signup form again
    assert_select 'h2.panel-title'#Calls error messages partial
    assert_select 'div.panel-body'#Call the panel html for error messages
  end
  
  test "accept a vaild signup" do
    get signup_path
    assert_difference "Chef.count", 1 do
      post chefs_path, params: { chef: { chefname: "Spencer ", email: "spencer@example.com ", password: "password ",
                                password_confirmation: "password" } }
    end
    follow_redirect!#Redirects user on successful signup
    assert_select 'chefs/show'#Goes to user's profile page - chefs/show
    assert_not flash.empty?#Assert that the successful flash message appears.
  end
end

  
