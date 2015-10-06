require 'open-uri'

URL = "http://iloveenglish.ru/vocabulary/verbs-words"
words = []

page = Nokogiri::HTML(open(URL)).css('div.singers tr>td:nth-child(2)')
page.search('span').remove

page.each do |word|
  words << word.content if word.content != ""
end

words.each do |word|
  w = word.split(/—/)
  Card.create(original_text: w[0].strip, translated_text: w[1].strip)
end
