class UpdateNullValueOnReceivers < ActiveRecord::Migration[6.1]
  def change
    remove_column :receivers, :award_id
  end
end
