class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :records
  has_many :charts, through: :records
end
