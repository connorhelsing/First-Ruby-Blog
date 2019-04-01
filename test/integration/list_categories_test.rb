require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @category2 = Category.create(name: "programming")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end


  test "should show categories listing" do
    sign_in_as(@user, "password")
    get categories_path
    assert_template 'categories/index'
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end


private
  def sign_in_as(user,password)
    post login_path, params: { session: { email: user.email, password: password } }
  end

end
