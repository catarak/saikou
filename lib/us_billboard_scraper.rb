require 'date'
require 'open-uri'

class UsBillboardScraper
  def initialize
    @base_url = "http://www.billboard.com/charts/hot-100/"
    initialize_models
  end

  def scrape
    current_week = date_of_next("Saturday")
    week_str = current_week.strftime("%Y-%m-%d")
    week_num = current_week.strftime("%U").to_i
    year_num = current_week.year
    still_scraping = true
    while (still_scraping) do
      begin
        current_chart = Nokogiri::HTML(open("#{@base_url}#{current_week.strftime("%Y-%m-%d")}"))
        song_name = current_chart.css("article#row-1 .row-title h2").text.strip
        artist_name = current_chart.css("article#row-1 .row-title h3").text.strip

        #find or create by everything
        year = Year.find_or_create_by(number: current_week.year)
        week = Week.find_or_create_by(number: current_week.strftime("%U").to_i)
        WeekYear.find_or_create_by(week_id: week.id, year_id: year.id)
        WeekCountry.find_or_create_by(week_id: week.id, country_id: @country.id)

        artist = Artist.find_or_create_by(name: artist_name)
        song = Song.create(name: song_name, artist_id: artist.id)
        #SongChart.create(song_id: song.id, chart_id: @chart.id)
        ChartWeek.create(week_id: week.id, chart_id: @chart.id, song_id: song.id)

        current_week = current_week - 1.week
        if year.number == 2013
          still_scraping = false
        end
      rescue OpenURI::HTTPError => the_error
        still_scraping = false
      end
    end
  end

  def initialize_models
    @country = Country.find_or_create_by(name: "United States")
    @chart = Chart.find_or_create_by(name: "Billboard", country_id: @country.id)
  end

  private
    def date_of_next(day)
      date  = Date.parse(day)
      delta = date > Date.today ? 0 : 7
      date + delta
    end
end