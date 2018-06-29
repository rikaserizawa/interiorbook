class Scrap < ApplicationRecord
  belongs_to :user
  belongs_to :interior
  
  validates :user_id, presence: true
  validates :interior_id, presence: true
end
