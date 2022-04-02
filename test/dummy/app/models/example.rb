class Example < ApplicationRecord
	enum col_enum: {
		zero: 0,
		one: 1,
		two: 2,
	}

	has_one :one
	has_one :two, through: :one

	has_many :fours
	has_many :threes, through: :fours

	has_and_belongs_to_many :fives, class_name: "Five"
end
