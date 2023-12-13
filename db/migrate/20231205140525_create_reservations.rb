class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :date, null: false
      t.string :email, limit: 255, null: false, comment: "予約者メールアドレス"
      t.string :name, limit: 50, null: false, comment: "予約者名"
      t.references :schedule, foreign_key: true, null: false, unique: true
      t.references :sheet, foreign_key: true, null: false, unique: true
      t.timestamps
    end
  end
end
