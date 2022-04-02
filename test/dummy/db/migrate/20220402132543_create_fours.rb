class CreateFours < ActiveRecord::Migration[7.0]
  def change
    create_table :fours do |t|
      t.references :example, null: false, foreign_key: true
      t.references :three, null: false, foreign_key: true

      t.timestamps
    end
  end
end
