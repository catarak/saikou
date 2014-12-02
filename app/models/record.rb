class Record < ActiveRecord::Base
  belongs_to :chart
  belongs_to :week
  belongs_to :song
end
