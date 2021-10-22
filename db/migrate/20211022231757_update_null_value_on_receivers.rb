class UpdateNullValueOnReceivers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :receivers, :award_id, true
  end
end
