class Week < ActiveRecord::Base
  has_many :records
  has_many :songs, through: :records
  has_many :charts, through: :records
  belongs_to :year
end
