class CreateFives < ActiveRecord::Migration[7.0]
  def change
    create_table :fives do |t|
      t.timestamps
    end

		create_table :examples_fives, id: false do |t|
			t.belongs_to :example
			t.belongs_to :part
		end
  end
end
