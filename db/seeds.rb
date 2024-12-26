require "nokogiri"
require "open-uri"

url = 'https://www.imdb.com/title/tt21975436/episodes/'
html_content = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
doc = Nokogiri::HTML(html_content)

# Destroy Episodes
puts "Deleting Episodes"
Episode.destroy_all

episodes_elements = doc.search('.ipc-list-card')

episodes_elements.each do |element|
  puts "========================================="

  episode = Episode.new
  # Find title
  title = element.search('.ipc-title__text').text.strip
  clean_title = title.sub(/^S\d+\.\E\d+ ∙ /, '')
  puts "Creating episode: #{clean_title}"
  episode.title = clean_title

  # Find release date
  date_element = element.search('.sc-f2169d65-5 span')
  release_date = Date.parse(date_element.text.strip) + 1
  episode.release_date = release_date

  # Find description
  desc = element.search('.ipc-html-content-inner-div').text.strip
  episode.description = desc

  # Find rating
  rating = element.search('.ipc-rating-star--rating').text.strip
  p rating.to_f
  episode.rating = rating

  ep_info = element.search('.ipc-title__text').text.strip
  ep_season = ep_info.match(/^S(?<season>\d+)\.E(?<episode>\d+)/)
  episode.season = ep_season[:season].to_i
  episode.episode_count = ep_season[:episode].to_i
  episode.save!
end
