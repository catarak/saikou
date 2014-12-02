require 'open-uri'
require 'date'

class JpOriconScraper

  def intialize
    @country = Country.create(name: "Japan")
    @chart = Chart.create(name: "Oricon", country: @country.id)
  end

end