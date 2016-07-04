class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.integer :question_number
      t.integer :status
      t.integer :duration
      t.integer :score
      t.integer :time_start, default: 0
      t.integer :time_end, default: 0

      t.timestamps null: false
    end
  end
end
