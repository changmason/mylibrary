class Book < ActiveRecord::Base
  attr_accessible :author, :description, :publish_date, :title

  belongs_to :category
end
