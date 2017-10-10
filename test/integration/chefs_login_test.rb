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
    assert_select "a[href=?]", login_path#Checks that there is a login path
    assert_select "a[href=?]", logout_path, count: 0#Checks that there is not a logout path (count = 0)
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
    assert_select "a[href=?]", login_path, count: 0#Checks that there is no login path
    assert_select "a[href=?]", logout_path#Checks that there is a logout path
    assert_select "a[href=?]", chef_path(@chef)#checks that there is a chef show page path
    assert_select "a[href=?]", edit_chef_path(@chef)#Checks that there is a path to edit chef's profile.
    
  end
end
