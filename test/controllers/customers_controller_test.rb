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

    it "should return many customer fields" do
      get :index
      assert_response :success

      data = JSON.parse @response.body
      data.each do |customer|
        customer.must_include "name"
        customer.must_include "registered_at"
        customer.must_include "postal_code"
        customer.must_include "phone"
        customer.must_include "account_credit"
        customer.must_include "movies_checked_out_count"
      end
    end

    it "returns all customers when no query params are given" do
      get :index
      assert_response :success

      data = JSON.parse @response.body
      data.length.must_equal Customer.count

      expected_names = {}
      Customer.all.each do |customer|
        expected_names[customer["name"]] = false
      end

      data.each do |customer|
        expected_names[customer["name"]].must_equal false
        expected_names[customer["name"]] = true
      end
    end
  end
end
