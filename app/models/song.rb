class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_charts
  has_many :charts, through: :song_charts
end
