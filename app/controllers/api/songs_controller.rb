class Api::SongsController < ApplicationController
  def index
    @week = Week.find(params[:week_id])
    @records = Record.where(week_id: @week.id)
    @countries = Country.joins(charts: :records).where(records: {week_id: @week.id})
  end
end
