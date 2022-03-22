require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get a page' do
    get posts_index_url
    assert_response :success
  end
end
