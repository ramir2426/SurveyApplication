class CreateSurveyTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_templates do |t|
      t.string :name
      t.string :province
      t.string :gender
      t.text :interests, array: true, default: []
      t.text :biography
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
