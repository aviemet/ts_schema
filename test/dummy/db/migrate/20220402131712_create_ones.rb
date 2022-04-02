class CreateOnes < ActiveRecord::Migration[7.0]
  def change
    create_table :ones do |t|
      t.references :example, null: false, foreign_key: true

      t.timestamps
    end
  end
end
