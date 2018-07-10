class Scrap < ApplicationRecord
  belongs_to :user
  belongs_to :interior
  counter_culture :interior
  
  validates :user_id, presence: true
  validates :interior_id, presence: true
  
  #ランキング
  def self.ranking
    self.group(:interior_id).order('count_interior_id DESC').count(:interior_id)
  end
end
