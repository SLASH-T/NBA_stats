#frozen_string_literal: false

module News
  #Provides access to author data
  class Articles
    def initialize(articles_data)
      @articles = articles_data
    end

    def author
      @articles['author']
    end

    def title
      @articles['title']
    end

    def description
      @articles['description']
    end

    def url
      @articles['url']
    end

    def urlToImage
      @articles['urlToImage']
    end

    def publishedAt
      @articles['publishedAt']
    end
    
  end
end
