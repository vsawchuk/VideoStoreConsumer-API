require 'test_helper'

class RentalsControllerTest < ActionDispatch::IntegrationTest
  describe "check-out" do
    it "associates a movie with a customer" do
      movie = movies(:one)
      customer = customers(:two)

      post check_out_url(title: movie.title), params: {
        customer_id: customer.id,
        due_date: Date.today + 1
      }
      assert_response :success

      # Reload from DB
      Movie.find(movie.id).customers.must_include Customer.find(customer.id)
    end

    it "requires a valid movie title" do
      post check_out_url(title: "does not exist"), params: {
        customer_id: customers(:two).id,
        due_date: Date.today + 1
      }
      assert_response :not_found
      data = JSON.parse @response.body
      data.must_include "errors"
      data["errors"].must_include "title"
    end

    it "requires a valid customer ID" do
      bad_customer_id = 13371337
      Customer.find_by(id: bad_customer_id).must_be_nil

      post check_out_url(title: movies(:one).title), params: {
        customer_id: bad_customer_id,
        due_date: Date.today + 1
      }
      assert_response :not_found
      data = JSON.parse @response.body
      data.must_include "errors"
      data["errors"].must_include "customer_id"
    end

    it "requires a due-date in the future" do
      # Obvious case: actually in the past
      post check_out_url(title: movies(:one).title), params: {
        customer_id: customers(:two).id,
        due_date: Date.today - 1
      }
      assert_response :bad_request
      data = JSON.parse @response.body
      data.must_include "errors"
      data["errors"].must_include "due_date"

      # Subtle case: today
      post check_out_url(title: movies(:one).title), params: {
        customer_id: customers(:two).id,
        due_date: Date.today
      }
      assert_response :bad_request
      data = JSON.parse @response.body
      data.must_include "errors"
      data["errors"].must_include "due_date"
    end

    it "only allows one check-out per movie-customer pair" do
      # Check assumptions: there is no existing pairing
      movie = movies(:one)
      customer = customers(:two)
      Rental.where(movie_id: movie.id, customer_id: customer.id).must_be_empty

      # Build the first pair
      post check_out_url(title: movie.title), params: {
        customer_id: customer.id,
        due_date: Date.today + 1
      }
      assert_response :success

      # Attempt to build the second pair
      post check_out_url(title: movie.title), params: {
        customer_id: customer.id,
        due_date: Date.today + 2
      }
      assert_response :bad_request
      data = JSON.parse @response.body
      data.must_include "errors"
      data["errors"].must_include "movie"
    end
  end

  describe "check-in" do
  end

  describe "overdue" do
  end
end
