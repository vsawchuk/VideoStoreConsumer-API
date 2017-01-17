class RentalsController < ApplicationController
  before_action :require_movie, only: [:check_out]
  before_action :require_customer, only: [:check_out]

  def check_out
    rental = Rental.new(movie: @movie, customer: @customer, due_date: params[:due_date])
    
    if rental.save
      render status: :ok, json: {}
    else
      render status: :bad_request, json: { errors: rental.errors.messages }
    end
  end

private
  def require_movie
    @movie = Movie.find_by title: params[:title]
    unless @movie
      render status: :not_found, json: { errors: { title: "No movie with title #{params[:title]}" } }
    end
  end

  def require_customer
    @customer = Customer.find_by id: params[:customer_id]
    unless @customer
      render status: :not_found, json: { errors: { customer_id: "No such customer #{params[:customer_id]}" } }
    end
  end
end
