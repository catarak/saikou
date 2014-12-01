class Year < ActiveRecord::Base
  has_many :week_years
  has_many :weeks, through: :week_years
end
