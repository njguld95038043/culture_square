require "test_helper"

class Public::RakutenBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get public_rakuten_books_search_url
    assert_response :success
  end
end
