class Book < ActiveRecord::Base
  attr_accessible :category_id, :author, :description, :publish_date, :title

  belongs_to :category
end
