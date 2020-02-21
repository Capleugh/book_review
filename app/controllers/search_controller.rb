class SearchController < ApplicationController
  def index
    render locals: {
      book_search: BookSearch.new
    }
  end
end
