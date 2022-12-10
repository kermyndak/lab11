class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.integer :input, null: false
      t.string :output, null: false

      t.timestamps
    end
    add_index :answers, :input, unique: true
  end
end
