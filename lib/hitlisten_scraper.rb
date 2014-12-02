require 'nokogiri'
require 'open-uri'

class HitlistenScraper

  def initialize
    @country = Country.find_or_create_by(name: "Denmark")
    @chart = Chart.find_or_create_by(name: "Hitlisten", country_id: @country.id)
    parse
  end

  def parse
    # @years = (2001..2014)
    # @week_nums = (1..52)
    @years = (2013..2014)
    @week_nums = (1..2)

    base_url = "http://www.hitlisten.nu/default.asp?w=&y=&list=a40"

    @years.each do |year_num|
      year = Year.find_or_create_by(number: year_num)
      yeared_url = base_url.gsub('y=', "y=#{year_num}")
      
      @week_nums.each do |week_num|
        week = Week.find_or_create_by(number: week_num, year_id: year.id)
        url = yeared_url.gsub('w=', "w=#{week_num}")
        doc = Nokogiri::HTML(open(url))

        artist_name = doc.css("div#linien:first div#artistnavn").text.strip
        artist = Artist.find_or_create_by(name: artist_name)
      
        title = doc.css("div#linien:first div#titel").text.strip
        song = Song.find_or_create_by(name: title, artist_id: artist.id)

        Record.create(chart_id: @chart.id, week_id: week.id, song_id: song.id)
      end
    end
  end
end

# Song.joins(:records).joins(weeks: :year).joins(charts: :country).joins(:weeks).where(years: {number: 2014}, countries: {name: "Denmark"}, weeks: {number: 2})