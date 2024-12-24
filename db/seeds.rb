require "nokogiri"
require "open-uri"

url = 'https://www.imdb.com/title/tt21975436/episodes/'
html_content = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
doc = Nokogiri::HTML(html_content)

titles = doc.search('h4 a .ipc-title__text').map do |element|
  full_title = element.text.strip
  full_title.sub(/^S\d+\.\E\d+ ∙ /, '')
end

titles.each { |title| puts title }



# OR (if you need to iterate over multiple elements)

# doc.search('.REPLACE_ME').each do |element|
# p element.text.strip
# end
