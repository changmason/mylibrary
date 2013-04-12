require 'spec_helper'


describe 'Books' do
  include Capybara::DSL

  before do
    Book.destroy_all
    # Capybara.current_driver = :selenium
  end

  let(:date) do
    Date.new(2011, 10, 25)
  end
  let(:book_attrs) do
    return {
      :author       => 'Daniel Kahneman',
      :title        => 'Thinking, Fast and Slow',
      :description  => 'In the international bestseller...',
      :publish_date => date
    }
  end

  context 'new' do
    it 'should create a book' do
      visit "/books/new"

      fill_in 'Author',      :with => book_attrs[:author]
      fill_in 'Title',       :with => book_attrs[:title]
      fill_in 'Description', :with => book_attrs[:description]
      select date.year,           :from => 'book[publish_date(1i)]'
      select date.strftime("%B"), :from => 'book[publish_date(2i)]'
      select date.day,            :from => 'book[publish_date(3i)]'
      click_on 'Save'

      page.should have_content('Book was successfully created.')
    end
  end

  context 'index' do
    it 'should display the books table with correct header and content' do
      book = Book.create(book_attrs)
      visit "/books/index"

      within('table.books tr:first-child') do
        page.should have_css('th', :text => 'Author')
        page.should have_css('th', :text => 'Title')
        page.should have_css('th', :text => 'Description')
        page.should have_css('th', :text => 'Publish date')
      end

      within("table.books tr#book_#{book.id}") do
        page.should have_css("td", :text => book.author)
        page.should have_css("td", :text => book.title)
        page.should have_css("td", :text => book.description)
        page.should have_css("td", :text => book.publish_date.to_s)
        page.should have_link('Show', :href => "/books/show/#{book.id}")
        page.should have_link('Edit', :href => "/books/edit/#{book.id}")
        page.should have_link('Destroy', :href => "/books/destroy/#{book.id}")
      end
    end
  end

  context 'show' do
    it 'should show the specified book' do
      book = Book.create(book_attrs)
      visit "/books/show/#{book.id}"

      page.should have_content(book.author)
      page.should have_content(book.title)
      page.should have_content(book.description)
      page.should have_content(book.publish_date.to_s)
    end
  end

  context 'edit' do
    it 'should update the specified book' do
      book = Book.create(book_attrs)
      visit "/books/edit/#{book.id}"

      fill_in 'Author',      :with => 'Mason Chang'
      fill_in 'Title',       :with => 'Reading Really Slow'
      fill_in 'Description', :with => 'Blah Blah Blah~'
      click_on 'Save'

      page.should have_content('Book was successfully updated.')
    end
  end

  context 'destroy' do
    it 'should destroy the specified book' do
      book = Book.create(book_attrs)
      visit "/books/index"

      within("table.books tr#book_#{book.id}") do
        click_on 'Destroy'
      end

      page.should_not have_css("table.books tr#book_#{book.id}")
    end
  end

end
