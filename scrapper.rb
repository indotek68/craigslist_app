# scrapper.rb
require 'nokogiri'
require 'open-uri'
require 'awesome_print'

# url = "today.html"
# page = Nokogiri::HTML(open(url))
# date = page.css(".row span .date").text
# text = page.css(".row a").text


def get_todays_rows(doc, date_str, regex)
  today_results = doc.css(".row").select do |link|
    link.css(".date").text == date_str &&
    link.css(".hdrlnk").text.match(regex) &&
    !link.css(".p").text.nil?
    # regex
  end
  # ap today_results
end

def get_page_results(date_str)
  dog_regex = /puppy|pup|dog/
  url = "today.html"
  page = Nokogiri::HTML(open(url))
  get_todays_rows(page, date_str, dog_regex)
end

def search(date_str)
  data = get_page_results(date_str)
  resultsArray = []

  data.each do |results|
    title = results.css(".hdrlnk").text
    link = results.css(".hdrlnk").first["href"]
    
    resultsArray.push({title: title, link: link})
  end
  ap resultsArray
end

# want to learn more about 
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
# today = "Aug 12"
search(today)


