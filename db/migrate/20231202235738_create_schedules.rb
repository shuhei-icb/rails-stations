class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.datetime "start_time", null: false, comment: "上映開始時刻"
      t.datetime "end_time", null: false, comment: "上映終了時刻"
      t.references :movie, foreign_key: true, null: false
      t.timestamps
    end
  end
end
