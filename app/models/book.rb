class Book < ActiveRecord::Base
  attr_accessible :category_id, :author, :description, :publish_date, :title

  belongs_to :category

  validates_presence_of :category_id, :author, :title
end
