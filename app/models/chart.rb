class Chart < ActiveRecord::Base
  belongs_to :country
  has_many :chart_weeks
  has_many :weeks, through: :chart_weeks
  has_many :song_charts
  has_many :songs, through: :song_charts
end
