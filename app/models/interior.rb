class Interior < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  has_many :scraps, dependent: :destroy
  has_many :favs, through: :scraps, source: :user
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :taste, presence: true
  validates :room, presence: true
  
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
  
  enum taste: { notype: 0, natural: 1, shabbychic:2, industrial:3, nordic:4, american:5, modern:6, other:7}
  enum  room: { noroom: 0, living: 1, kitchen:2, sanitary:3, bedroom:4, childrenroom:5, entrance:6, another:7}
end

