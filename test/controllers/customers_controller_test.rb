require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest

  describe "List customers" do
    it "returns a JSON array" do
      get customers_url
      assert_response :success
      @response.headers['Content-Type'].must_include 'json'

      # Attempt to parse
      data = JSON.parse @response.body
      data.must_be_kind_of Array
    end

    it "should return many customer fields" do
      get customers_url
      assert_response :success

      data = JSON.parse @response.body
      data.each do |customer|
        customer.must_include "id"
        customer.must_include "name"
        customer.must_include "registered_at"
        customer.must_include "postal_code"
        customer.must_include "phone"
        customer.must_include "account_credit"
        customer.must_include "movies_checked_out_count"
      end
    end

    it "returns all customers when no query params are given" do
      get customers_url
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

    describe "sorting" do
      it "can sort by name" do
        get customers_url, params: { sort: 'name' }
        assert_response :success

        data = JSON.parse @response.body
        data.length.must_equal Customer.count

        # Verify sorted order
        data.each_with_index do |customer, i|
          if i + 1 >= data.length
            break
          end

          customer['name'].must_be :<=, data[i+1]['name']
        end
      end

      it "can sort by registered_at" do
        get customers_url, params: { sort: 'registered_at' }
        assert_response :success

        data = JSON.parse @response.body
        data.length.must_equal Customer.count

        # Verify sorted order
        data.each_with_index do |customer, i|
          if i + 1 >= data.length
            break
          end

          DateTime.parse(customer['registered_at']).must_be :<=, DateTime.parse(data[i+1]['registered_at'])
        end
      end

      it "can sort by postal_code" do
        get customers_url, params: { sort: 'postal_code' }
        assert_response :success

        data = JSON.parse @response.body
        data.length.must_equal Customer.count

        # Verify sorted order
        data.each_with_index do |customer, i|
          if i + 1 >= data.length
            break
          end

          customer['postal_code'].must_be :<=, data[i+1]['postal_code']
        end
      end

      it "returns an error for an invalid sort field" do
        get customers_url, params: { sort: 'gnome' }
        assert_response :bad_request

        data = JSON.parse @response.body
        data.must_be_kind_of Hash

        data.must_include 'errors'
        data['errors'].must_include 'sort'
      end
    end
  end
end
