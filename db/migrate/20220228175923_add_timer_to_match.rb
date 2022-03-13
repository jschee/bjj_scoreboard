class AddTimerToMatch < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :start_time, :integer, default: 0
    add_column :matches, :end_time, :integer, default: 0
  end
end
