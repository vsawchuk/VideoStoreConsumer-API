require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  describe "List customers" do
    it "returns a JSON array" do
      get :index
      assert_response :success
      @response.headers['Content-Type'].must_include 'json'

      # Attempt to parse
      data = JSON.parse @response.body
      data.must_be_kind_of Array
    end
  end
end
