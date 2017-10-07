require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Spencer", email: "spencer@example.com", password: "password")  
  end
  
  test "invalid login is rejected" do
    get login_path# Goes to login path.
    assert_template 'sessions/new'# Serves login form.
    post login_path, params: { sessions: { email: " " , password: " " } }# Email & password are invalid/empty.
    assert_template 'sessions/new'#Returns to login form.
    assert_not flash.empty?#This assertion fails.
    get root_path#We go to another route
    assert flash.empty?#This time, the flash message is empty.
  end
 
  test "accept valid credentials and begin session" do
    get login_path
    assert_template 'sessions_new'
    post login_path, params: {session: { email: @chef.email, password: @chef.password } }
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end
