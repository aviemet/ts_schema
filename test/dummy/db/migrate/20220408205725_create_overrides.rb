class CreateOverrides < ActiveRecord::Migration[7.0]
  def change
    create_table :overrides do |t|
      t.string :encrypted_password, null: false
      t.string :omit
      t.string :deep

      t.timestamps
    end
  end
end
