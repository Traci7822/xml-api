class CreateAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.text :purpose
      t.text :cash_amount
      t.timestamps
    end
  end
end