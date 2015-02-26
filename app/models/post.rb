class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  
  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  
  def total_votes
    upvotes - downvotes
  end
  
  def upvotes
    votes.where(vote: true).size
  end
  
  def downvotes
    votes.where(vote: false).size
  end
end