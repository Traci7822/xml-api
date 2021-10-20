class CreateFilers < ActiveRecord::Migration[6.1]
  def change
    create_table :filers do |t|
      t.text :ein
      t.text :name
      t.text :address
      t.text :city
      t.text :state
      t.text :zip_code
      t.references :award, null: false, foreign_key: true

      t.timestamps
    end
  end
end
