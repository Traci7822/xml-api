class AddReceiverToAwards < ActiveRecord::Migration[6.1]
  def change
    add_reference :awards, :receiver, null: false, foreign_key: true
  end
end
