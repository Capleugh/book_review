class Book
  attr_reader :title, :author

  def initialize(book_attributes)
    @title = book_attributes[:title_suggest]
    @author = book_attributes[:author_name]
  end
end
