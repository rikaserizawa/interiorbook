class Interior < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  
  has_many :scraps, dependent: :destroy
  has_many :favs, through: :scraps, source: :user
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  
  # お気に入り 
  def fav(other_user)
      self.scraps.find_or_create_by(user_id: other_user.id)
  end

  def unfav(other_user)
    scrap = self.scraps.find_by(user_id: other_user.id)
    scrap.destroy if scrap
  end

  def faving?(other_user)
    self.favs.include?(other_user)
  end

end

