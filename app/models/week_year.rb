class WeekYear < ActiveRecord::Base
  belongs_to :week
  belongs_to :year
end
