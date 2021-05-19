class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :comment_likes
end
