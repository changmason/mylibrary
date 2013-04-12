class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book])
    @book.save
    render :text => 'Book was successfully created.'
  end

end
