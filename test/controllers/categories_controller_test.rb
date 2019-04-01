require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

def setup
  @category = Category.create(name: "sports")
  @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  @user2 = User.create(username: "mike", email: "mike@example.com", password: "password2", admin: false)
end


test "should get categories index" do
  sign_in_as(@user, "password")
  get categories_path
  assert_response :success
end

test "should get new" do
  sign_in_as(@user, "password")
  get new_category_path
  assert_response :success

end

test "should get show" do
  sign_in_as(@user, "password")
  get category_path(@category)
  assert_response :success
end

test "should redirect create when not admin" do
  sign_in_as(@user2, "password2")
  assert_no_difference 'Category.count' do
    post categories_path, params: { category: {name: "sports"} }
  end
  assert_redirected_to categories_path
end

end
