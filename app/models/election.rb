class Election < ActiveRecord::Base
  has_many :votes
  has_many :users, :through => :votes

  attr_accessible :description, :name, :outcome
  validates :name, presence: true, length: { maximum: 50 }
  validates :name, length: { maximum: 400 }

end
