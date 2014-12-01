class ChartWeek < ActiveRecord::Base
  belongs_to :chart
  belongs_to :week
end
