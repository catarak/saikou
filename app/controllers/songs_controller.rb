class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def play
    iframe = YouTube.run(params[:search_keyword])
    render html: iframe.html_safe
  end

end
