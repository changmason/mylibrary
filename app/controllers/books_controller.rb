class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params[:book])
    @book.save
    render :text => 'Book was successfully created.'
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(params[:book])
    render :text => 'Book was successfully updated.'
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books/index'
  end

end
