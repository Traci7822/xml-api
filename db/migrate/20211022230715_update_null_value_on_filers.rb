class UpdateNullValueOnFilers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :filers, :award_id, true
  end
end
