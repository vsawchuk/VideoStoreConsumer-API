class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  validates :movie, uniqueness: { scope: :customer }
  validates :due_date, presence: true
  validate :due_date_in_future

  def due_date_in_future
    return unless self.due_date
    unless due_date > Date.today
      errors.add(:due_date, "Must be in the future")
    end
  end
end
