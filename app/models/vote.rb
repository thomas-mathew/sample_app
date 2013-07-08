class Vote < ActiveRecord::Base
  belongs_to :election, :dependent => :destroy
  belongs_to :user

  attr_accessible :direction, :quantity

  validates_uniqueness_of :user_id, :scope => [:election_id]
end
