class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true #追記
  validates :body, presence: true #追記
  validates :body ,length: { maximum: 200} #追記
end
