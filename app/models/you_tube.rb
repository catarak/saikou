class YouTube
  attr_reader :client, :search_term
  RETURN_TO_SENDER = '<iframe width="640" height="390" src="//www.youtube.com/embed/PU5xxh5UX4U" frameborder="0" allowfullscreen></iframe>'

  def initialize(search_term)
    @client = YouTubeIt::Client.new(:dev_key => ENV['google_api_key'])
    @search_term = search_term
  end

  def self.run(search_term)
    self.new(search_term).get_vid
  end

  def get_vid
    videos = self.client.videos_by(:query => [self.search_term]).videos
    videos.empty? ? RETURN_TO_SENDER : get_embedded_vid(videos)
  end

  def get_embedded_vid(videos)
    videos.first.embed_html5(:id => "ytplayer", :width => 640, :height => 390)
  end

end
