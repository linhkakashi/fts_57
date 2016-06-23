class CreateExamQuestions < ActiveRecord::Migration
  def change
    create_table :exam_questions do |t|
      t.references :exam, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
