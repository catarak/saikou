class MusiclineScraper < ActiveRecord::Base

  def initialize
    @country = Country.create(name: "Germany")
    @chart = Chart.create(name: "musicline", country_id: @country.id)
  end

  def year_week_maker
    @years = [1959..2014]
    @week_nums = [1..53]

    @years.each do |year|
      year = Year.create(number: year)
      @week_nums.each do |week|
        @week = Week.create(number: @week, year_id: year.id)
        # WeekCountry.create(week_id: week.id, country_id: @country.id)
        # YearWeek.create(year_id: year.id, week_id: week.id)
        # ChartWeek.create(chart_id: @chart.id, week_id: week.id)
      end
    end
  end

  def url_generator
    base_url = "http://www.musicline.de/de/charts/single?page=0&week=&year="
    @urls = @week_nums.each do |week|
              weeked_url = base_url.gsub('week=', 'week=week')
              @years.collect do |year|
                weeked_url.gsub('year=', 'year=year')
              end
            end
  end

  def self.parse
    @urls.each do |url|
      doc = Nokogiri::HTML(open(url))
      
      artist_name = doc.css("tr:nth-child(2) .chart-position.artist-right p a").text
      artist = Artist.create(name: artist_name)
      
      title = doc.css("tr:nth-child(2) .chart-position.titel p a").text
      song = Song.create(name: title, artist_id: artist.id)
      Record.create(chart_id: @chart.id, week_id: @week.id, song_id: song.id)

      # SongChart.create(song_id: song.id, chart_id: @chart.id)
    end
  end

end

