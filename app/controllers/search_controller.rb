class SearchController < ApplicationController
  def index
    book_conn = Faraday.new(url: "http://openlibrary.org/") do |f|
      f.adapter Faraday.default_adapter
    end

    book_response = book_conn.get("search.json?title=the_man_who_saw_everything&author=deborah_levy")

    review_conn = Faraday.new(url: "https://api.nytimes.com/svc/books/v3") do |f|
      f.adapter Faraday.default_adapter
    end

    review_response = review_conn.get("reviews.json?title=The+Man+Who+Saw+Everything&api-key=#{ENV["NYTIMES_API_KEY"]}")

    book_json = JSON.parse(book_response.body, symbolize_names: true)
    review_json = JSON.parse(review_response.body, symbolize_names: true)

# require "pry"; binding.pry
    @book = book_json[:docs][0]
    @reviews = review_json[:results]
  end
end
