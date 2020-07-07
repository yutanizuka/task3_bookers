class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true #追記
  validates :body, presence: true #追記
  validates :body ,length: { maximum: 200} #追記
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
