class Comment < ActiveRecord::Base
  
  belongs_to :post
  belongs_to :user
  has_many :votes, as: :voteable
  
  validates :body, presence: true
  
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