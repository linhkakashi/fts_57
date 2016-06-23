class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.integer :status
      t.float :duration
      t.float :spend_time
      t.integer :score

      t.timestamps null: false
    end
  end
end
