require 'test_helper'

class RentalTest < ActiveSupport::TestCase
  let(:rental_data) {
    {
      checkout_date: "2017-01-08:",
      due_date: Date.today + 1,
      customer: customers(:one),
      movie: movies(:one)
    }
  }

  before do
    @rental = Rental.new(rental_data)
  end

  describe "Constructor" do
    it "Has a constructor" do
      Rental.create!(rental_data)
    end

    it "Has a customer" do
      @rental.must_respond_to :customer
    end

    it "Cannot be created without a customer" do
      data = rental_data.clone()
      data.delete :customer
      c = Rental.new(data)
      c.valid?.must_equal false
      c.errors.messages.must_include :customer
    end

    it "Has a movie" do
      @rental.must_respond_to :movie
    end

    it "Cannot be created without a movie" do
      data = rental_data.clone
      data.delete :movie
      c = Rental.new(data)
      c.valid?.must_equal false
      c.errors.messages.must_include :movie
    end
  end

  describe "due_date" do
    it "Cannot be created without a due_date" do
      data = rental_data.clone
      data.delete :due_date
      c = Rental.new(data)
      c.valid?.must_equal false
      c.errors.messages.must_include :due_date
    end

    it "due_date on a new rental must be in the future" do
      data = rental_data.clone
      data[:due_date] = Date.today - 1
      c = Rental.new(data)
      c.valid?.must_equal false
      c.errors.messages.must_include :due_date

      # Today is also not in the future
      data = rental_data.clone
      data[:due_date] = Date.today
      c = Rental.new(data)
      c.valid?.must_equal false
      c.errors.messages.must_include :due_date
    end

    it "rental with an old due_date can be updated" do
      r = Rental.find(rentals(:overdue).id)
      r.returned = true
      r.save!
    end

  end
end
