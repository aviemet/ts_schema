class CreateThrees < ActiveRecord::Migration[7.0]
  def change
    create_table :threes do |t|
      t.timestamps
    end
  end
end
