class BookSearch
  def book
    book_conn = Faraday.new(url: "http://openlibrary.org/") do |f|
      f.adapter Faraday.default_adapter
    end

    book_response = book_conn.get("search.json?title=the_man_who_saw_everything&author=deborah_levy")


    book_json = JSON.parse(book_response.body, symbolize_names: true)

    book_json[:docs].map do |book_data|
      Book.new(book_data)
    end
  end

  def title
    book[0].title
  end

  def author
    book[0].author
    # I don't love this and I may have overdone it? With more time, I think I could have found a better way. Would love some feedback!
  end

  def reviews
    review_conn = Faraday.new(url: "https://api.nytimes.com/svc/books/v3") do |f|
      f.adapter Faraday.default_adapter
    end

    review_response = review_conn.get("reviews.json?title=The+Man+Who+Saw+Everything&api-key=#{ENV["NYTIMES_API_KEY"]}")

    review_json = JSON.parse(review_response.body, symbolize_names: true)

    review_json[:results].map do |review_data|
      Review.new(review_data)
    end
  end
end
