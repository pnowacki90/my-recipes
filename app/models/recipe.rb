class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  belongs_to :chef
  validates :chef_id, presence: true
  default_scope -> { order(updated_at: :desc) }
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  
  def average_rating
    if ratings.size==0
      0
    else
      ratings.sum(:rate) / ratings.size
    end
  end
end