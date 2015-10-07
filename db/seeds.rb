require "open-uri"

URL = "http://iloveenglish.ru/vocabulary/verbs-words"

page = Nokogiri::HTML(open(URL)).css("div.singers tr>td:nth-child(2)")
page.search("span").remove

page.each do |word|
  w = word.content if word.content != ""
  unless w.nil?
    w = w.split(/—/)
    Card.create(original_text: w[0].strip, translated_text: w[1].strip)
  end
end
