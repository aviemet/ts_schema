class CreateExamples < ActiveRecord::Migration[7.0]
  def change
    create_table :examples do |t|
      t.string :col_string, null: false
      t.text :col_text, null: false
      t.integer :col_integer, null: false
			t.integer :col_enum, null: false
      t.bigint :col_bigint, null: false
      t.float :col_float, null: false
      t.decimal :col_decimal, null: false
      t.json :col_json
      t.jsonb :col_jsonb
      t.binary :col_binary
      t.boolean :col_boolean
      t.date :col_date
      t.datetime :col_datetime
      t.timestamp :col_timestamp
			t.inet :col_inet
			t.cidr :col_cidr
			t.macaddr :col_macaddr
    end
  end
end
