class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1500 }
  validates :user_id, presence: true
  
  def average_rating
    comments.average(:rating).to_f
  end
end