module GoogFinance
  QUOTE_URL = 'https://www.google.com/finance?q='
  COMPANY_DESC_SELECTOR = 'div.companySummary'
  REUTER_LINK = 'a#m-rprofile'

  def company_summary(symbol)
    data = { summary: '', rlink: '' }
    html = Nokogiri::HTML(open("#{QUOTE_URL}#{symbol.upcase}"))
    data[:summary] = html.css(COMPANY_DESC_SELECTOR).first.text
    data[:rlink] = html.css(REUTER_LINK).first.attr('href')
    return data
  end
end