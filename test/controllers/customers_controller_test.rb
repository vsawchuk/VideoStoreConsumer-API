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
        customer.must_include "movies_checked_out"
      end
    end

    it "returns all customers when no query params are given" do
      get :index
      assert_response :success

      data = JSON.parse @response.body
      data.length.must_equal Customer.count

      expected_names = Customer.all.map do |customer|
        customer.name
      end

    end
  end
end
