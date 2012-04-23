class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  def importance
  end
end
