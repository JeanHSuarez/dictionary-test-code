require 'test_helper'

class OxfordDictionaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get oxford_dictionary_index_url
    assert_response :success
  end

end
