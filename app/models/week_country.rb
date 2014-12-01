class WeekCountry < ActiveRecord::Base
  belongs_to :week
  belongs_to :country
end
