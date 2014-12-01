class Week < ActiveRecord::Base
  has_many :week_years
  has_many :years, through: :week_years
  has_many :week_countries
  has_many :countries, through: :week_countries
  has_many :chart_weeks
  has_many :charts, through: :chart_weeks
end
