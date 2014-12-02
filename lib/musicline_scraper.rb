require 'nokogiri'
require 'open-uri'

class MusiclineScraper

  def initialize
    @country = Country.find_or_create_by(name: "Germany")
    @chart = Chart.find_or_create_by(name: "musicline", country_id: @country.id)
    parse
  end

  def parse
    # @years = (1959..2014)
    # @week_nums = (1..53)
    @years = (2013..2014)
    @week_nums = (1..2)

    base_url = "http://www.musicline.de/de/charts/single?page=0&week=&year="
    # @urls = []

    @years.each do |year_num|
      year = Year.find_or_create_by(number: year_num)
      yeared_url = base_url.gsub('year=', "year=#{year_num}")
      
      @week_nums.each do |week_num|
        week = Week.find_or_create_by(number: week_num, year_id: year.id)
        # @urls << yeared_url.gsub('week=', "week=#{week}")
        url = yeared_url.gsub('week=', "week=#{week_num}")
        doc = Nokogiri::HTML(open(url))

        artist_name = doc.css("tr:nth-child(2) .chart-position.artist-right p a").text
        artist = Artist.find_or_create_by(name: artist_name)
      
        title = doc.css("tr:nth-child(2) .chart-position.titel p a").text
        song = Song.find_or_create_by(name: title, artist_id: artist.id)

        Record.create(chart_id: @chart.id, week_id: week.id, song_id: song.id)
      end
    end
  end

  # def url_generator
  #   base_url = "http://www.musicline.de/de/charts/single?page=0&week=&year="
  #   @urls = []
  #   @week_nums.each do |week|
  #     @weeked_url = base_url.gsub('week=', "week=#{week}")
  #     @years.each do |year|
  #       @urls << @weeked_url.gsub('year=', "year=#{year}")
  #     end
  #   end
  # end

  # def parse
  #   @urls.each do |url|
  #     doc = Nokogiri::HTML(open(url))
      
  #     artist_name = doc.css("tr:nth-child(2) .chart-position.artist-right p a").text
  #     artist = Artist.find_or_create_by(name: artist_name)
      
  #     title = doc.css("tr:nth-child(2) .chart-position.titel p a").text
  #     song = Song.find_or_create_by(name: title, artist_id: artist.id)
  #     Record.create(chart_id: @chart.id, week_id: @week.id, song_id: song.id)
  #   end
  # end

end

# Song.joins(:records).joins(weeks: :year).joins(charts: :country).joins(:weeks).where(years: { number: 2014 }, countries: {name: "Germany"}, weeks: { number: 2})
