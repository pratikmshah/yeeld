module GoogFinance
  QUOTE_URL = 'https://www.google.com/finance?q='
  COMPANY_DESC_SELECTOR = 'div.companySummary'

  def company_summary(symbol)
    data = Nokogiri::HTML(open("#{QUOTE_URL}#{symbol.upcase}")).css(COMPANY_DESC_SELECTOR)
  end
end