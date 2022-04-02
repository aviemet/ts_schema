class One < ApplicationRecord
  belongs_to :example
	has_one :two
end
