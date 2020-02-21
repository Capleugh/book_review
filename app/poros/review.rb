class Review
  attr_reader :body, :publication_date

  def initialize(review_attributes)
    @body = review_attributes[:summary]
    @publication_date = review_attributes[:publication_dt]
  end
end
