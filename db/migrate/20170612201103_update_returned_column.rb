class UpdateReturnedColumn < ActiveRecord::Migration[5.0]
  def change
    change_column_default :rentals, :returned, false
  end
end
