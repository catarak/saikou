class SongChart < ActiveRecord::Base
  belongs_to :song
  belongs_to :chart
end
