require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  let (:customer_data) {
    {
      "name": "Ada Testington III",
      "registered_at": "Wed, 29 Apr 2015 07:54:14 -0700",
      "address": "12345 Ada Ave E",
      "city": "Seattle",
      "state": "WA",
      "postal_code": "98107",
      "phone": "(123) 456-7890",
      "account_credit": 13.15
    }
  }

  before do
    @customer = Customer.new(customer_data)
  end

  describe "Constructor" do
    it "Can be created" do
      Customer.create!(customer_data)
    end

    it "Has rentals" do
      @customer.must_respond_to :rentals
    end

    it "Has movies" do
      @customer.must_respond_to :movies
    end
  end

  describe "movies_checked_out_count" do
    it "Should exist" do
      @customer.must_respond_to :movies_checked_out_count
    end
  end
end
