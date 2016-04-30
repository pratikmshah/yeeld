module GoogFinance

  # Company description
  QUOTE_URL = 'https://www.google.com/finance?q='
  COMPANY_DESC_SELECTOR = 'div.companySummary'                  # returns the company description
  REUTER_LINK = 'a#m-rprofile'                                  # returns url link to reuters company profile

  # Company news articles
  NEWS_URL = 'https://www.google.com/finance/company_news?q='
  NEWS_TITLE_SELECTOR = 'div#news-main div.news span.name'      # returns title of the article
  NEWS_LINKS_SELECTOR = 'div#news-main div.news span.name a'    # returns the url link of article
  NEWS_SRC_SELECTOR   = 'div#news-main div.news div.byline'     # returns src of article ex: Daily Mail - Apr 15, 2015

  def company_summary(symbol)
    data = { summary: '', rlink: '' }
    html = Nokogiri::HTML(open("#{QUOTE_URL}#{symbol.upcase}"))
    data[:summary] = html.css(COMPANY_DESC_SELECTOR).first.text
    data[:rlink] = html.css(REUTER_LINK).first.attr('href')
    return data
  end

  def company_news(symbol)
    data = []
    html = Nokogiri::HTML(open("#{NEWS_URL}#{symbol.upcase}"))
    data.push(info_to_array(html.css(NEWS_SRC_SELECTOR)))
  end

  private

    # parse information
    def info_to_array(obj)
      remove_escape( obj.map { |data| data.text } )
    end

    # remove new line (\n) escape character
    def remove_escape(arr)
      arr.each do |str|
        check = ''
        while check != nil do
          str.slice!("\n")
        end
      end
    end

end