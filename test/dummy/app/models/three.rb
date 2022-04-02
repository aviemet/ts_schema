class Three < ApplicationRecord
  has_many :fours
	has_many :examples, through: :fours
end
