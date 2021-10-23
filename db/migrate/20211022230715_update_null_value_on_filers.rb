class UpdateNullValueOnFilers < ActiveRecord::Migration[6.1]
  def change
    remove_column :filers, :award_id
  end
end
