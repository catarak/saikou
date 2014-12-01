class Country < ActiveRecord::Base
  has_many :charts
  has_many :week_countries
  has_many :weeks, through: :week_countries
end
