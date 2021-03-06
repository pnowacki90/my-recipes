class Rating < ApplicationRecord
  belongs_to :chef
  belongs_to :recipe
  validates :rate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
