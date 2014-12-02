class AddSongIdToChartWeeks < ActiveRecord::Migration
  def change
    add_column :chart_weeks, :song_id, :integer
  end
end
